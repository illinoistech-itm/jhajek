
# Program To Read video 
# and Extract Frames 
import cv2 
  
# Function to extract frames 
def FrameCapture(path): 
      
    # Path to video file 
    vidObj = cv2.VideoCapture(path) 
  
    # Used as counter variable 
    count = 0
  
    # checks whether frames were extracted 
    success = 1
    framecounter = 1
    
    while success: 
  
        # vidObj object calls read 
        # function extract frames 
        success, image = vidObj.read() 
  
        # Saves the frames with frame-count , 30 frames per second - so 1 keep 1 of every 30 frames
        if framecounter % 30 == 0:
          cv2.imwrite("/home/controller/run/frame%d.jpg" % count, image) 
          framecounter = 0
          
        count += 1
        framecounter += 1
  
# Driver Code 
if __name__ == '__main__': 
  
    # Calling the function 
    FrameCapture("/home/controller/Downloads/AI_Test_Videos/BattleOfMosul_AI_test2.mp4") 

