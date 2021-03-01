use studentrecords;
db.studentrecords.insertOne({SampleValue1 : 255, SampleValue2 : "randomStringOfText"});
db.studentrecords.insertOne({SampleValue1 : 253, SampleValue2 : "randomStringOfText2"});
db.studentrecords.insertOne({SampleValue1 : 254, SampleValue2 : "randomStringOfText3"});
db.studentrecords.find();