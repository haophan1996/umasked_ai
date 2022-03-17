# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.
import torch


def print_hi(name):
    # Use a breakpoint in the code line below to debug your script.
    print(f'Hi, {name}')


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    print_hi('PyCharm')

import requests
import cv2


faces = ['face.png', 'face2.png', 'face3.png', 'face4.png', 'face5.png']

for face in faces:
    resp = requests.post("http://localhost:5000/predict",
                                 files={"file": open(face, 'rb')})
    print(resp)
    print(resp.json())
