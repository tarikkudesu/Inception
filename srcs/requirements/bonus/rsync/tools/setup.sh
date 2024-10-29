#!/bin/bash

# cron_job="0 8 * * 1 /backup.sh"
cron_job="* * * * * /backup.sh"
{ env | grep MYSQL; echo "$cron_job"; } | crontab -
cron -f
