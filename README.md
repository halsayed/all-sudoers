# all-sudoers
A script to make all normal linux users sudoers, runs once at first boot


## Test Linux Images

This script has been test on the following CentOS GenericCloud images:
- **CentOS 7 image tested:** [https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2](https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2)
- **CentOS 8 image tested:** [https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-GenericCloud-8.1.1911-20200113.3.x86_64.qcow2](https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-GenericCloud-8.1.1911-20200113.3.x86_64.qcow2)


## Initial setup

Create you custom linux image, a sample cloud-init is provided in this repo. Just setting a default root password. After boot the VM, login as root and perform the following steps:


**Step 1:** install all_sudoers script

`curl -o /usr/bin/all_sudoers.sh https://raw.githubusercontent.com/halsayed/all-sudoers/master/all_sudoers.sh
chmod +x /usr/bin/all_sudoers.sh`


**Step 2:** Add a service to run after cloud-init, it will run once after booting.

`curl -o /etc/systemd/system/all_sudoers.service https://raw.githubusercontent.com/halsayed/all-sudoers/master/all_sudoers.service
systemctl daemon-reload
systemctl enable all_sudoers.service`


**Step 3:** Power off the VM and it should be ready to publish to catalog.

_Note:_ Don't forget to remove CD-ROM ide.3 that is being attached automatically by Prism to apply cloud-init in the first template VM creatation. It will conflict with SSP guided cloud-init settings.
