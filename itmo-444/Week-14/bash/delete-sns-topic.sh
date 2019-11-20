#!/bin/bash

# https://docs.aws.amazon.com/cli/latest/reference/sns/delete-topic.html
# https://docs.aws.amazon.com/cli/latest/reference/sns/list-topics.html

$TOPICARN=`aws sqs list-topics`
aws sns delete-topic --topic-arn $TOPICARN | awk {'print $2'}  