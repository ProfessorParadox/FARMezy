import cv2
import numpy as np
import time
from time import sleep
from datetime import datetime
import pyrebase
import os
import requests
import json
from picamera import PiCamera

camera = PiCamera()

firebaseConfig = {
    'apiKey': "AIzaSyAFXPvYwRKXMeF0JST4mrdk3npnKD3sjew",
    'authDomain': "farmezy-7164e.firebaseapp.com",
    'databaseURL': "https://farmezy-7164e-default-rtdb.firebaseio.com",
    'projectId': "farmezy-7164e",
    'storageBucket': "farmezy-7164e.appspot.com",
    'messagingSenderId': "340007917263",
    'appId': "1:340007917263:web:cfb70a6f5a9b1c5249c9ba",
    'measurementId': "G-YLWW4CKKM0"
}

firebase = pyrebase.initialize_app(firebaseConfig)
storage = firebase.storage()

#load YOLO
net = cv2.dnn.readNet("yolov3-tiny.weights", "yolov3-tiny.cfg")
classes = []
with open("coco.names", "r") as f:
    classes = [line.strip() for line in f.readlines()]

animals = ["cat", "dog", "horse", "bird", "sheep", "cow", "elephant", "bear", "zebra", "giraffe"]

layer_names = net.getLayerNames()
outputlayers = [layer_names[i - 1] for i in net.getUnconnectedOutLayers()]
colors = np.random.uniform(0, 255, size = (len(classes), 3))

#loading image
#camera.start_preview()

font = cv2.FONT_ITALIC
while True:
    sleep(5)
    camera.capture('input.jpg')

    img = cv2.imread("input.jpg")
    img = cv2.resize(img, None, fx = 0.4, fy = 0.4)
    height, width, channels = img.shape
    

    #detecting objects
    blob = cv2.dnn.blobFromImage(img, 0.00392, (416, 416), (0, 0, 0), True, crop = False)

    net.setInput(blob)
    outs = net.forward(outputlayers)

    #showing informations on the screen
    class_ids = []
    confidences = []
    boxes = []
    for out in outs:
        for detection in out:
            scores = detection[5:]
            class_id = np.argmax(scores)
            confidence = scores[class_id]
            if confidence > 0.2:
                #object detected
                center_x = int(detection[0] * width)
                center_y = int(detection[1] * height)
                w = int(detection[2] * width)
                h = int(detection[3] * height)

                #cv2.circle(img, (center_x, center_y), 10, (0, 255, 0), 2)
                #Rectangle Co-ordinates
                x = int(center_x - w/2)
                y = int(center_y - h/2)

                #cv2.rectangle(img, (x, y), (x + w, y + h), (0, 255, 0), 2)
                boxes.append([x, y, w, h])
                confidences.append(float(confidence))
                class_ids.append(class_id)

    #print(len(boxes))
    indexes = cv2.dnn.NMSBoxes(boxes, confidences, 0.5, 0.4)
    #f == 0
    #print(indexes)
    prevLabel = ""
    for i in range(len(boxes)):
        if i in indexes:
            x, y, w, h = boxes[i]
            label = str(classes[class_ids[i]])
            #if label == "car":
                #f = f + 1

            confidence = confidences[i]
            color = colors[class_ids[i]]
            cv2.rectangle(img, (x, y), (x + w, y + h), color, 2)
            cv2.putText(img, label + " " + str(round(confidence, 2)), (x, y + 30), font, 0.5, color, 1)
            if label in animals:
                prevLabel = label
                filename = "output.jpg"
                cv2.imwrite(filename, img)
                time.sleep(0.5)
                now = datetime.now()
                dt = now.strftime("%d/%m/%Y %H:%M:%S")
                name = label + ".jpg"
                print(name+" uploaded")
                storage.child(filename).put(filename)
                response = requests.patch('https://farmezy-7164e-default-rtdb.firebaseio.com/image-detection/-Mqpj4y7qlRRegL2H79X.json', json={'label': label, 'time-stamp': dt})
                time.sleep(2)
                

    #cv2.imshow("Image", img)
    if prevLabel not in animals:
        label = "No animal detected"
        filename = "output.jpg"
        cv2.imwrite(filename, img)
        time.sleep(0.5)
        now = datetime.now()
        dt = now.strftime("%d/%m/%Y %H:%M:%S")
        name = label + ".jpg"
        print(name+" uploaded")
        storage.child(filename).put(filename)
        response = requests.patch('https://farmezy-7164e-default-rtdb.firebaseio.com/image-detection/-Mqpj4y7qlRRegL2H79X.json', json={'label': label, 'time-stamp': dt})
        time.sleep(2)
    key = cv2.waitKey(1)
    if key == 27:
        break
#camera.stop_preview()
cv2.destroyAllWindows()
