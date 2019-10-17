import base64
import cv2
import zmq
import sys

ip = sys.argv[1]
count = sys.argv[2]
counter = 0
context = zmq.Context()
footage_socket = context.socket(zmq.PUB)
footage_socket.connect('tcp://' + ip + ':5555')

camera = cv2.VideoCapture(0)  # init the first camera
camera2 = cv2.VideoCapture(1)  # init the first camera

while counter != count:
    try:
        grabbed, frame = camera.read()  # grab the current frame
       # frame = cv2.resize(frame, (640, 480))  # resize the frame
        frame = cv2.resize(frame, (800,620))  # resize the frame
        encoded, buffer = cv2.imencode('.jpg', frame)
        jpg_as_text = base64.b64encode(buffer)
        footage_socket.send(jpg_as_text)

    except KeyboardInterrupt:
        camera.release()
        cv2.destroyAllWindows()
        break
    
    counter+=1

    counter = 0

while counter != count:
    try:
        grabbed, frame = camera2.read()  # grab the current frame
       # frame = cv2.resize(frame, (640, 480))  # resize the frame
        frame2 = cv2.resize(frame, (800,620))  # resize the frame
        encoded, buffer = cv2.imencode('.jpg', frame2)
        jpg_as_text2 = base64.b64encode(buffer)
        footage_socket.send(jpg_as_text2)

    except KeyboardInterrupt:
        camera.release()
        cv2.destroyAllWindows()
        break
        
    counter+=1

    counter = 0
