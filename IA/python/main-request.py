#importacoes necessarias
import cv2
import numpy as np
import imutils
import mahotas
import argparse
import urllib2
import json
from imutils.video import VideoStream

def requestMaker(codigo, droneid, rotaid):
    url = "localhost:8080"
    path = "/aviso"
    data = {
	    "codigo" : codigo,
	    "droneid" : droneid,
	    "rotaid": rotaid
    }
    print("que")
    jsondata = json.dumps(data)

    conn = urllib2.httplib.HTTPConnection(url)

    headers = {'Content-Type': 'application/json', "Accept": "text/plain"}

    conn.request('POST', path, jsondata, headers)

detect = False

#definir os argumentos necessarias
ap = argparse.ArgumentParser()

ap.add_argument("-p", "--picamera", type=int, default = -1,
	help="a Raspberry Pi Camera deve ser usada?")

ap.add_argument("-v", "--video", default = 0,
	help="zika do baguio video")

ap.add_argument("-c", "--corno", default = 0,
	help = "RGB da cor para ser detectada")

ap.add_argument("-r", "--red",
	help = "necessary RED")

ap.add_argument("-g", "--green",
	help = "necessary Green")

ap.add_argument("-b", "--blue",
	help = "necessary blue")

args = vars(ap.parse_args())

#verificar qual fonte utilizar, raspa ou video
if args["video"] == 0:
    vs = VideoStream(usePiCamera = args["picamera"] > 0).start()
else:
    cap = cv2.VideoCapture(args["video"])

#conversor de RGB para HSV
color = np.uint8([[[args["blue"], args["green"], args["red"]]]])
hsv_color = cv2.cvtColor(color, cv2.COLOR_BGR2HSV)
hue = hsv_color[0][0][0]

colorLower = (hue-10,100,100)
colorUpper = (hue+10,255,255)

print("[INFO] HSV COLOR UP" + str(colorUpper))
print("[INFO] HSV COLOR LOW" + str(colorLower))

i = 1

while 1:
    #verificar qual fonte utilizar, raspa ou video
    if args["video"] == 0:
        frame = vs.read()
    else:
        ret, frame = cap.read()
    
    #redimensionamento da imagem
    frame = imutils.resize(frame, width = 1080)

    #conversao da imagem original para hsv, cinza, blur e binario
    hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    blurred = cv2.GaussianBlur(gray, (5,5), 0)
    thresh = cv2.threshold(blurred, 60, 255, cv2.THRESH_BINARY)[1]

    #aplicacao mascara
    mask = cv2.inRange(hsv, colorLower, colorUpper)

    #encontrar os contornos da mascara e iniciar a 
    #coordenada no centro do objeto
    cnts = cv2.findContours(mask.copy(), cv2.RETR_EXTERNAL,
        cv2.CHAIN_APPROX_SIMPLE)
    cnts = cnts[0] if imutils.is_cv2() else cnts[1]
    center = None

    #ha algo correspondente a cor na imagem
    if len(cnts) > 0:
        #encontrar o maior contorno na mascara
        #calcular o circulo do centro
        detect = True
        c = max(cnts, key = cv2.contourArea)
        ((x,y), radius) = cv2.minEnclosingCircle(c)
        M = cv2.moments(c)
        center = (int(M["m10"] / M["m00"]), int(M["m01"] / M["m00"]))

        if radius > 10:
            cv2.circle(frame, (int(x), int(y)), int(radius), (0,255,255), 2)
            cv2.circle(frame, center, 5, (0,0,255), -1)

    if detect:
        i += 1
        requestMaker("22", "1", i)
        print("ha algo na tela")
        detect = False
    else:
        print("nao ha nada na tela")
        
    cv2.imshow("frame", frame)

    key = cv2.waitKey(1) & 0xFF

    if key == ord("q"):
        break

print("\n encerrando programa \n")

cv2.destroyAllWindows()	
cap.release()
cv2.destroyAllWindows()

