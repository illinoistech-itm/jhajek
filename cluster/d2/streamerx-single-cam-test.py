import base64
import cv2
import zmq
import sys
import argparse
import multiprocessing as mp

#########################################################################################################################
# https://stackoverflow.com/questions/4290834/how-to-get-a-list-of-video-capture-devices-web-cameras-on-linux-ubuntu-c
# You can use the following bash command:
# v4l2-ctl --list-devices
#In order to use the above command, you must install package v4l-utils before. In Ubuntu/Debian you can use the command:
# sudo apt-get install v4l-utils

def get_parser():
    parser = argparse.ArgumentParser(description="Detectron2 Streaming Demo")
    parser.add_argument("--ip", help="ip address to stream to")
    parser.add_argument(
        "--count",
        type=int,
        default=5,
        help="default amount of framecaptures to stream",
    )
    parser.add_argument(
        "--height",
        type=int,
        default=800,
        help="default amount of time to stream for",
    )
    parser.add_argument(
        "--width",
        type=int,
        default=600,
        help="default amount of time to stream for",
    )
    parser.add_argument(
        "--port",
        type=int,
        default=5555,
        help="default remote port to connect to",
    )            
    return parser

args = get_parser().parse_args()
#ip = args.ip
count = args.count
print(count)
counter = 0
context = zmq.Context()
footage_socket = context.socket(zmq.PUB)
footage_socket.connect('tcp://' + args.ip + ":" + str(args.port))

# initialize the first camera
camera = cv2.VideoCapture(0)  # init the first camera

while counter != count:
    print("camera 1")
    try:
        topic = "camera1"
        grabbed, frame = camera.read()  # grab the current frame
        frame = cv2.resize(frame, (args.height,args.width))  # resize the frame
        footage_socket.send_string(topic, zmq.SNDMORE)
        footage_socket.send_pyobj(frame)        
        #encoded, buffer = cv2.imencode('.jpg', frame)
        #jpg_as_text = base64.b64encode(buffer)
        #footage_socket.send(jpg_as_text)

    except KeyboardInterrupt:
        camera.release()
        cv2.destroyAllWindows()
        break
    
    counter+=1
    print(counter)

camera.release()
counter = 0