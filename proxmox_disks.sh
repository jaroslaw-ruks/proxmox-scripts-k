#!/bin/bash
if [ ! -b /dev/mapper/storage_unencrypted ] ; then
	echo 'storage is encrypted';
	echo 'type password for open disk';
	read -s cryptsetup_password;
        echo -n $cryptsetup_password | cryptsetup luksOpen /dev/mapper/sm1--vg-storage_encrypted storage_unencrypted -
	echo 'unencrypting...';
	sleep 5
else
	echo 'storage is unencrypted';
fi
vm_status=$(qm status 100 | awk '{print $2}')

if [ "$vm_status" != "running" ]; then
	echo 'start Windows';
	qm start 100
else
	echo 'Windows is running';
fi
