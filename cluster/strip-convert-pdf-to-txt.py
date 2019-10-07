import subprocess
import pyttsx3
import sys
import locale
import ghostscript
import os
import time
import collections

names=os.listdir(sys.argv[2])
names.sort()
print(names)
items = []

engine = pyttsx3.init()
rate = engine.getProperty('rate')
engine.setProperty('rate', 140)

for i in range(len(names)):
  args = [
          "ps2pdf", #value doesn't matter
          "-dNOPAUSE", "-dBatch", "-dSAFER",
          "-sDEVICE=txtwrite",
          "-sOutputFile=" + sys.argv[1],
          "-c", ".setpdfwrite",
          "-f", sys.argv[2] + "/" +  str(names[i]) 
         ]

  # arguments have to be bytes, encode them
  encoding = locale.getpreferredencoding()
  args = [a.encode(encoding) for a in args]

  ghostscript.Ghostscript(*args)
  #filename = "output.txt"

  with open(sys.argv[1]) as f:
      content = f.readlines()

  content = [x.strip() for x in content]

  print("filename")
  print(str(names[i]))
  #engine.say("filename")
  # Gets just the filename -- no extension 
  engine.say(os.path.splitext(str(names[i]))[0])
  
  time.sleep(.5)
  # Now take the object and percentage counts 
  for y in content:
      if y.split()[1] > .80:
          items.append(y.split()[0])
  
  c = collections.Counter(items)
  for w in items:
    print("here is what I see. I see")  
    print(w)
    time.sleep(.25)

    #engine.say("here is what I see. I see a")
    engine.say("I see ") 
    for i in items:
      engine.say(c[i]) 
      engine.say(i)
      time.sleep(.25)
      
      engine.runAndWait()
      engine.stop()

