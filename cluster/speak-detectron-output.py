import pyttsx3
engine = pyttsx3.init()
rate = engine.getProperty('rate')
print (rate)
engine.setProperty('rate', 100)
engine.say("this is what I see")
engine.runAndWait()
