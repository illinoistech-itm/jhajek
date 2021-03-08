use studentrecords;
db.studentrecords.insertOne({Title : "New Idea", Name : "Abraham Lincoln", Comment : "Four score and seven years ago our fathers brought forth on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal."});
db.studentrecords.insertOne({Title : "Someone is wrong on the internet", Name : "Annie Mouse", Comment : "https://www.xkcd.com/386/"});
db.studentrecords.insertOne({Title : "Presidential Quote", Name : "President James Madison", Comment : "If men were angels, no government would be necessary"});
db.studentrecords.find();