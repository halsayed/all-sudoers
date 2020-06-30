#!/bin/bash
# Name: all_sudoers.sh
# Purpose: list all linux normal users and adding them to sudoers
# Author: Husain Ebrahim, 23-June-2020
# ---------------------------------------------------------------

# get minimum and maximum UID, usually 1000 and 60000
min_uid=$(grep "^UID_MIN" /etc/login.defs)
max_uid=$(grep "^UID_MAX" /etc/login.defs)

# list users from /etc/passwd and add to wheels and sudoers
echo "----------[ Normal User Accounts ]---------------"
for user in $(awk -F':' -v "min=${min_uid##UID_MIN}" -v "max=${max_uid##UID_MAX}" '{ if ( $3 >= min && $3 <= max ) print $1 }' "/etc/passwd"); do
	echo "adding ${user} to sudoers"
	usermod -aG wheel $user
	echo "${user}  ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/$user
done

# allow password authentication in sshd
sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
systemctl restart sshd

# we need to run once, clean up service and delete files
systemctl disable all_suoders.service
rm -f /etc/systemd/system/all_sudoers.service
systemctl daemon-reload
rm $0
