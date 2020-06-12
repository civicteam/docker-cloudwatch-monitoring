# A cron starter script that first adds all environment variables to /etc/environment
# so that they are available to cron
env >> /etc/environment
cron -f
