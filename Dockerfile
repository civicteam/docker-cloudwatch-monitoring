FROM ubuntu
MAINTAINER https://github.com/ariabov

# Install monitoring scripts

RUN apt-get update && \
  apt-get install -y unzip wget libwww-perl libdatetime-perl cron syslog-ng-core && \
  rm -rf /tmp/* /var/tmp/*

RUN wget http://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.1.zip && \
  unzip CloudWatchMonitoringScripts-1.2.1.zip && \
  rm CloudWatchMonitoringScripts-1.2.1.zip

WORKDIR aws-scripts-mon

# Removed because AWS credentials are provided
# by EC2 (The server must have an IAM profile)
#COPY awscreds.template awscreds.template

# Setup cron

ADD crontab /etc/crontab
ADD cron-env.sh ./
RUN crontab /etc/crontab

# Log file for debugging

RUN touch /var/log/cron.log
RUN chmod 0644 /var/log/cron.log

ENTRYPOINT ./cron-env.sh
