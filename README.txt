Settings:
- clone repository
- modify the reminder_file variable in the add_reminder.sh file putting the path of the reminder_file.txt file
- edit the reminder_file variable in the reminder.sh file
- modify the channel variable in the reminder.sh file putting the chosen channel preceded by #
- put the rockchat weebhook url in the webhook_url variable in the reminder.sh file. The webhook can be obtained from the administration - integrations section of rockechat
- modify the file owner with the user who will execute the script
- modify the permissions on the folder chmod 700 *
- schedule the reminder.sh script in the crontab every 30 min
30 * * * * /path/reminder.sh

Usage:
- run the add_reminder.sh script setting the year, month, day, hour and message of the reminder.
- the reminder will be saved in the reminder_file.txt file
- one hour before the deadline, the reminder.sh script scheduled in the crontab will take care of sending the reminder to the chosen rockechat channel and deleting it from the reminder_file.txt file
