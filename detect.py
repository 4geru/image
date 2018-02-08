import cv2
import sys
import os
import os.path
import time
import re
def GetFileNum(sInFdr):
    if not os.path.isdir(sInFdr): return 0
    s=0
    for root, dirs, files in os.walk(sInFdr):
        s+=len(files)
    return s
def detect(filename, cascade_file = "./lbpcascade_animeface.xml"):
    i = GetFileNum(os.getcwd()+'/public/image')
    if not os.path.isfile(cascade_file):
        raise RuntimeError("%s: not found" % cascade_file)
    TARGET_DIR = os.getcwd()+'/public/image'
    if not os.path.isdir(TARGET_DIR):
        os.makedirs(TARGET_DIR)

    cascade = cv2.CascadeClassifier(cascade_file)
    image = cv2.imread(filename, cv2.IMREAD_COLOR)
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    gray = cv2.equalizeHist(gray)

    faces = cascade.detectMultiScale(gray,
                                     scaleFactor = 1.1,
                                     minNeighbors = 5,
                                     minSize = (24, 24))
    for (x, y, w, h) in faces:
        cv2.rectangle(image, (x, y), (x + w, y + h), (0, 0, 255), 2)
        dst = image[y:y+h, x:x+w]
        cv2.imwrite(os.path.join(TARGET_DIR, str(i)+'.jpg'), dst)
        i = i + 1
        print(i)

    # cv2.imwrite(os.path.join(TARGET_DIR, filename.split('.')[0]+'.jpg'), image)
    # cv2.imshow("AnimeFaceDetect", image)
    # cv2.waitKey(0)

if len(sys.argv) != 2:
    sys.stderr.write("usage: detect.py <filename>\n")
    sys.exit(-1)
detect(sys.argv[1])