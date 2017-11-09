<?php

#  Process.php

# Check queue for new messages -> If queue contains messages,  read first message and set visibility to 300 

# Then do below -- else exit the script

# Take SQS body content which is the recipt or UUID

# Make RDS connection

# Select * from Records WHERE receipt=’$UUIID’

# Make S3 connection 

# get S3 object

# Run image manipulation code with the retreived S3 object as the source

# if above step is succesful:
    #  Upload finsihed object to S3 finsihed URL (take the returned URL and save it to a variable)
    #  Update RDS database row - use UPDATE command with the UUID as the WHERE clause
    #  Update the Finished URL (was blank)  and update STATUS field 0 -> 1
    #  Send SNS notification to endpoint (email or SMS)
    #  Delete Queue message based on Receipt Handle



?>