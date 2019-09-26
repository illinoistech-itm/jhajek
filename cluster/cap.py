import cv2
cap = cv2.VideoCapture('C:\Users\palad\Downloads\AI_Test_Videos-20190925T232151Z-001\AI_Test_Videos\BattleOfMosul_AI_test2.mp4')
count = 0
while cap.isOpened():
    ret,frame = cap.read()
    cv2.imshow('window-name',frame)
    cv2.imwrite("frame%d.jpg" % count, frame)
    count = count + 1
    if cv2.waitKey(10) & 0xFF == ord('q'):
        break


cap.release()
cv2.destroyAllWindows()  # destroy all the opened windows