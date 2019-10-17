import base64
import cv2
import zmq
import sys

ip = sys.argv[1]
count = int(sys.argv[2])
print(count)
counter = 0
context = zmq.Context()
footage_socket = context.socket(zmq.PUB)
footage_socket.connect('tcp://' + ip + ':5555')

camera = cv2.VideoCapture(-1)  # init the first camera

while counter != count:
    print("camera 1")
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
    print(counter)


counter = 0
camera2 = cv2.VideoCapture(1)  # init the second camera

while counter != count:
    print("camera 2")
    try:
        grabbed, frame2 = camera2.read()  # grab the current frame
       # frame = cv2.resize(frame, (640, 480))  # resize the frame
        frame2 = cv2.resize(frame2, (800,620))  # resize the frame
        encoded, buffer = cv2.imencode('.jpg', frame2)
        jpg_as_text2 = base64.b64encode(buffer)
        footage_socket.send(jpg_as_text2)

    except KeyboardInterrupt:
        camera.release()
        cv2.destroyAllWindows()
        break
        
    counter+=1

    counter = 0
