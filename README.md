# all-sudoers
A script to make all normal linux users sudoers, runs once at first boot

CentOS 7 image tested: https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2
CentOS 8 image tested: https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-GenericCloud-8.1.1911-20200113.3.x86_64.qcow2

curl -o /usr/bin/all_sudoers.sh https://raw.githubusercontent.com/halsayed/all-sudoers/master/all_sudoers.sh
chmod +x /usr/bin/all_sudoers.sh

curl -o /etc/systemd/system/all_sudoers.service https://raw.githubusercontent.com/halsayed/all-sudoers/master/all_sudoers.service

systemctl daemon-reload
systemctl enable all_sudoers.service
