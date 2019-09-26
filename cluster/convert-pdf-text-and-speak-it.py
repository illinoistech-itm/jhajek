import subprocess
import pyttsx3
import sys
import locale
import ghostscript

engine = pyttsx3.init()
rate = engine.getProperty('rate')
engine.setProperty('rate', 140)

args = [
        "ps2pdf", #value doesn't matter
        "-dNOPAUSE", "-dBatch", "-dSAFER",
        "-sDEVICE=txtwrite",
        "-sOutputFile=" + sys.argv[1],
        "-c", ".setpdfwrite",
        "-f", sys.argv[2]
        ]

# arguments have to be bytes, encode them
encoding = locale.getpreferredencoding()
args = [a.encode(encoding) for a in args]

ghostscript.Ghostscript(*args)

filename = "output.txt"

with open(filename) as f:
    content = f.readlines()

content = [x.strip() for x in content]

for w in content:
  engine.say("here is what I see. I see a")  
  engine.say(w)
   
engine.runAndWait()
engine.stop()
