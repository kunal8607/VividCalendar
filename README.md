# README
This applicaion is a POC to sync google calendar and its events of a user.
devise omniauth and google calendar API were used.

To sync the user calendars a rake task is prepared, the task will be syncing the calendars only of active users, i.e those users who were signed in with application in last 15 days.
This rake task can be configured in cron using whenever gem

for other users manual sync option is provided
