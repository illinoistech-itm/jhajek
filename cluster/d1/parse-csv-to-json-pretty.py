import sys, getopt
import csv
import json

# https://www.idiotinside.com/2015/09/18/csv-json-pretty-print-python/
# https://stackoverflow.com/questions/19697846/how-to-convert-csv-file-to-multiline-json
# https://stackoverflow.com/questions/19697846/how-to-convert-csv-file-to-multiline-json
with open("1950.csv") as csvfile:
      # fields = ("usaf","wban","year","date","time","latitude","longitude","elevation","wind_direction","qc1","sky_clng_hgt","qc2","visi_distance","qc3","airtemp","qc4","dew_temp","qc5","atm_pressure","qc6")
   reader = csv.DictReader(csvfile)
   for row in reader:     
     with open("p1950.json", "a") as g:
       g.write(json.dumps(row, indent=4 ))
