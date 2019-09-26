import re
import sys
import csv

# https://stackoverflow.com/questions/2084069/create-a-csv-file-with-values-from-a-python-list
# https://stackoverflow.com/questions/16822016/write-multiple-variables-to-a-file
file = open("1950a.txt","r")              # reading the file
#open the csv file and add the headers
with open("1950.csv", "w") as cfile:
      cfile.write("usaf,wban,year,date,time,latitude,longitude,elevation,wind_direction,qc1,sky_clng_hgt,qc2,visi_distance,qc3,airtemp,qc4,dew_temp,qc5,atm_pressure,qc6\n")

      #open the csv file for appending and write the content of the list
      for line in file:
        val = line.strip()
        (usaf,wban,year,date,time,latitude,longitude,elevation,wind_direction,qc1,sky_clng_hgt, qc2, visi_distance,qc3, airtemp,qc4,dew_temp,qc5,atm_pressure,qc6) = (val[4:10],val[10:15],int(val[15:19]),val[15:23],val[23:27], (float(val[28:34])/1000),(float(val[34:40])/1000),int(val[46:51]), int(val[60:63]),int(val[63:64]),int(val[70:75]), int(val[75:76]),int(val[78:84]),int(val[84:85]),(float(val[87:92])/100),int(val[92:93]),(float(val[93:98])/1000), int(val[98:99]),(float(val[99:104])/1000),int(val[104:105]))
        fields = [usaf,wban,year,date,time,latitude,longitude,elevation,wind_direction,qc1,sky_clng_hgt, qc2, visi_distance,qc3, airtemp,qc4,dew_temp,qc5,atm_pressure,qc6]
        with open("1950.csv", "a") as myfile:
          wr = csv.writer(myfile)
          wr.writerow(fields)  
