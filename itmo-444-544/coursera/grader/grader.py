#!/usr/bin/python3

import json
import os
import shutil

# For autograding
SUBMISSION_FILE = "/shared/submission/create-env-module-02-results.txt"
# For Live testing
#SUBMISSION_FILE = "/home/coder/project/learn/create-env-module-02-results.txt"

# Read results from file
with open(SUBMISSION_FILE) as f:
    results_str = f.read()

# Convert JSON string to Python dictionary
# Sample results: 
# {"Name": "module-5-destroy-assessment", "gtotal": 1.0, "datetime": "20240307052700", "sha": "f2a2d321457ecc6a0980a60df8fbe2238dd300380749ac43f6cf0b7dca0d4370"}
results_dict = json.loads(results_str)

# Generate feedback based on score
score = results_dict['gtotal']

if score == 1.0:
    feedback = "Well done you have achieved all of the objectives of this assessment!"
elif score < 1.0 and score > 0.8:
    feedback = "You have most of the major concepts, though some of the incorrect items may be preventing major logical pieces from being completed. You might want to review the feedback from the python3 ./create-env.test.py"
else:
    feedback = "Something has gone wrong -- major logical pieces from being completed. You might want to review the feedback from the python3 ./create-env.test.py, or reach out for help via the course Slack channel."

# Print feedback
coursera_formatted_dict = {"fractionalScore": score, "feedback": feedback}

print(coursera_formatted_dict)

# Write results to feedback.json
with open("/shared/feedback.json", 'w') as outfile:
    json.dump(coursera_formatted_dict, outfile)