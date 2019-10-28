import sys, getopt
import csv
import json

# https://www.idiotinside.com/2015/09/18/csv-json-pretty-print-python/
# https://stackoverflow.com/questions/19697846/how-to-convert-csv-file-to-multiline-json
# https://stackoverflow.com/questions/19697846/how-to-convert-csv-file-to-multiline-json
with open("1950.csv") as csvfile:
  reader = csv.DictReader(csvfile)
  for row in reader:
    with open("s1950.json", "a") as f:
      f.write(json.dumps(row))
      f.write('\n')
