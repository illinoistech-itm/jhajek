#!/bin/bash

# https://docs.aws.amazon.com/cli/latest/reference/sns/delete-topic.html
# https://docs.aws.amazon.com/cli/latest/reference/sns/list-topics.html

TOPICARN=`aws sns list-topics | awk {'print $2'}`
aws sns delete-topic --topic-arn $TOPICARN