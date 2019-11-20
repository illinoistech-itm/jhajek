#!/bin/bash

# https://docs.aws.amazon.com/cli/latest/reference/sqs/delete-queue.html
# https://docs.aws.amazon.com/cli/latest/reference/sqs/list-queues.html

$SQSURL=`aws sqs list-queues --queue-name-prefix inclass-jrh`
aws sqs delete-queue --queue-url $SQSURL