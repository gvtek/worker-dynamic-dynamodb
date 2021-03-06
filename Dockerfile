FROM ubuntu:trusty

MAINTAINER Stockflare <info@stockflare.com>

ENV DEBIAN_FRONTEND noninteractive

ENV AWS_REGION us-east-1

ENV CONFD_VERSION 0.10.0

ENV CHECK_INTERVAL 60

ENV LOG_LEVEL info

ENV DYNAMODB_TABLE_REGEXP '.*'

ENV ENABLE_READS_AUTOSCALING true

ENV READS_UPPER_THRESHOLD 90

ENV READS_LOWER_THRESHOLD 30

ENV DECREASE_READS_WITH 50

ENV INCREASE_READS_UNIT percent

ENV DECREASE_READS_UNIT percent

ENV MIN_PROVISIONED_READS 1

ENV MAX_PROVISIONED_READS 500

ENV ENABLE_WRITES_AUTOSCALING true

ENV WRITES_UPPER_THRESHOLD 90

ENV WRITES_LOWER_THRESHOLD 30

ENV DECREASE_WRITES_WITH 50

ENV INCREASE_WRITES_UNIT percent

ENV DECREASE_WRITES_UNIT percent

ENV MIN_PROVISIONED_WRITES 1

ENV MAX_PROVISIONED_WRITES 500

ENV SNS_MESSAGE_TYPES "scale-up,scale-down,high-throughput-alarm,low-throughput-alarm"

RUN apt-get update && apt-get install -y python-pip

RUN sudo pip install awscli dynamic-dynamodb && \
    sudo pip install --upgrade botocore boto3

ADD etc/confd /etc/confd

ADD bin/confd-0.10.0-linux-amd64 /bin/confd

ADD bin/broadcast /usr/bin/broadcast

WORKDIR /stockflare

ADD boot boot

CMD ["./boot"]
