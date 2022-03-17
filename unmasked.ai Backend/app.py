import cv2
from flask import Flask, jsonify, request
import torch
import torch.nn as nn
import torch.nn.functional as F
import torchvision.transforms as transforms
import numpy as np
import base64

from PIL import Image
import io

classes_train = ['Frustrated', 'Bored', 'Nervous', 'Happy', 'Neutral', 'Sad', 'Surprise']


def accuracy(outputs, labels):
    _, preds = torch.max(outputs, dim=1)
    return torch.tensor(torch.sum(preds == labels).item() / len(preds))


class ImageClassificationBase(nn.Module):
    def training_step(self, batch):
        images, labels = batch
        out = self(images)
        loss = F.cross_entropy(out, labels)
        return loss

    def validation_step(self, batch):
        images, labels = batch
        out = self(images)
        loss = F.cross_entropy(out, labels)
        acc = accuracy(out, labels)
        return {'val_loss': loss.detach(), 'val_acc': acc}

    def validation_epoch_end(self, outputs):
        batch_losses = [x['val_loss'] for x in outputs]
        epoch_loss = torch.stack(batch_losses).mean()
        batch_accs = [x['val_acc'] for x in outputs]
        epoch_acc = torch.stack(batch_accs).mean()
        return {'val_loss': epoch_loss.item(), 'val_acc': epoch_acc.item()}

    def epoch_end(self, epoch, result):
        print("Epoch [{}], last_lr: {:.5f}, train_loss: {:.4f}, val_loss: {:.4f}, val_acc: {:.4f}".format(
            epoch, result['lrs'][-1], result['train_loss'], result['val_loss'], result['val_acc']))


def conv_block(in_channels, out_channels, pool=False):
    layers = [nn.Conv2d(in_channels, out_channels, kernel_size=3, padding=1),
              nn.BatchNorm2d(out_channels),
              nn.ELU(inplace=True)]
    if pool: layers.append(nn.MaxPool2d(2))
    return nn.Sequential(*layers)


class ResNet(ImageClassificationBase):
    def __init__(self, in_channels, num_classes):
        super().__init__()

        self.conv1 = conv_block(in_channels, 128)
        self.conv2 = conv_block(128, 128, pool=True)
        self.res1 = nn.Sequential(conv_block(128, 128), conv_block(128, 128))
        self.drop1 = nn.Dropout(0.5)

        self.conv3 = conv_block(128, 256)
        self.conv4 = conv_block(256, 256, pool=True)
        self.res2 = nn.Sequential(conv_block(256, 256), conv_block(256, 256))
        self.drop2 = nn.Dropout(0.5)

        self.conv5 = conv_block(256, 512)
        self.conv6 = conv_block(512, 512, pool=True)
        self.res3 = nn.Sequential(conv_block(512, 512), conv_block(512, 512))
        self.drop3 = nn.Dropout(0.5)

        self.classifier = nn.Sequential(nn.MaxPool2d(6),
                                        nn.Flatten(),
                                        nn.Linear(512, num_classes))

    def forward(self, xb):
        out = self.conv1(xb)
        out = self.conv2(out)
        out = self.res1(out) + out
        out = self.drop1(out)

        out = self.conv3(out)
        out = self.conv4(out)
        out = self.res2(out) + out
        out = self.drop2(out)

        out = self.conv5(out)
        out = self.conv6(out)
        out = self.res3(out) + out
        out = self.drop3(out)

        out = self.classifier(out)
        return out


model = ResNet(1, len(classes_train))
model.load_state_dict(torch.load('emotion_m-30-128-0.008.pt'))

face_cascade = cv2.CascadeClassifier('data/haarcascade_frontalface_alt2.xml')

app = Flask(__name__)

@app.route('/')
def api():
    return 'you'


@app.route('/predict', methods=['POST','GET'])
def predict():
    if request.method == 'GET':
        return "You must use get method"
    if request.method == 'POST':
        # file = request.files['file']
        # if isinstance(file, str):
        #     file = base64.b64decode(file)

        # image = file.read()
        image = base64.b64decode(str(request.values.get("file", type=str, default=None)))
        class_name = get_prediction(image=image)
        name = class_name[0]
        x = str(class_name[1][0])
        y = str(class_name[1][1])
        w = str(class_name[1][2])
        h = str(class_name[1][3])
        return jsonify({'class_name': class_name[0], 'x': x, 'y': y, 'w': w, 'h': h})


# def transform(image):
# image = Image.open(io.BytesIO(image))
# image = tt.functional.to_pil_image(image)
# image = tt.functional.to_grayscale(image)
# image = tt.ToTensor()(image).unsqueeze(0)
# return image

def transform_image(image_bytes):
    my_transforms = transforms.Compose([
        transforms.ToPILImage(),
        transforms.Resize(48),
        transforms.Grayscale(num_output_channels=1),
        transforms.ToTensor()])

    image = cv2.imdecode(np.frombuffer(image_bytes, np.uint8), -1)
    ROI_gray = None
    face = face_cascade.detectMultiScale(image, 1.3, 5)

    for (x, y, w, h) in face:
        cords = [x, y, w, h]
        ROI_gray = image[y:y + h, x:x + w]
        ROI_gray = cv2.resize(ROI_gray, (48, 48), interpolation=cv2.INTER_AREA)
        
    if ROI_gray is not None:
        return [my_transforms(ROI_gray).unsqueeze(0), cords]
    else:
        cords = [None, None, None, None]
        return [my_transforms(image).unsqueeze(0), cords]


def get_prediction(image):
    image = transform_image(image)
    tensor = model(image[0])
    cords = image[1]
    pred = torch.max(tensor, dim=1)[1].tolist()
    label = classes_train[pred[0]]
    return [label, cords]


if __name__ == '__main__':
    app.run()
