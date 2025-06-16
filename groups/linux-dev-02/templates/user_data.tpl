#! /usr/bin/bash
# Redirect the user-data output to the console logs
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

#Restart iscsid to take in the new initiator name.
systemctl restart iscsid

#set hostname
hostnamectl set-hostname ${HOSTNAME} --static