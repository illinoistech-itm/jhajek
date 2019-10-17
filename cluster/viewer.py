import cv2
import zmq
import base64
import numpy as np

context = zmq.Context()
footage_socket = context.socket(zmq.SUB)
footage_socket.bind('tcp://*:5555')
footage_socket.setsockopt_string(zmq.SUBSCRIBE, np.unicode(''))
count = 0
framecounter = 1 

while True:
    try:
        frame = footage_socket.recv_string()
        img = base64.b64decode(frame)
        npimg = np.fromstring(img, dtype=np.uint8)
        source = cv2.imdecode(npimg, 1)
        #cv2.imshow("Stream", source)
        if framecounter % 30 == 0:
          cv2.imwrite("/home/controller/run/frame%d.jpg" % count, source)
          print ("Writing a frame ") 
          count += 1
          print (count)
          framecounter = 0 

        framecounter += 1
        if count == 20:
            break

#        cv2.waitKey(1)
#        if cv2.waitKey(1) &0XFF == ord('x'):
#          break


    except KeyboardInterrupt:
        cv2.destroyAllWindows()
        break
