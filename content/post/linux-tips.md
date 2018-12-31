---
title: "Linux Tips"
date: 2018-10-17T14:48:00+08:00
lastmod: 2018-12-31T16:51:00+08:00
draft: false
tags: ["linux", "tips", "disk"]
categories: ["Linux"]
---

## 快速挂载硬盘

### Step 1:
It is needed to verify whether the new drive is visible in the system. Using fdisk command, it can be identified.
```
fdisk -l
```
It will list all drives available in the system including mounted and unmounted drives. Here assume a new drive label is /dev/ssd

### Step 2:
It is needed to create the file system ext4(in shortly say as formatting drive). So make sure drive is fresh/empty one. It a drive has already data, don’t enter this step, instead skip to next step. The following command helps to create file system
```
mkfs -t ext4 /dev/ssd
```

### Step 3:
Now create a new directory in the root(or in desired path) to mount a formatted drive using mkdir command

```
mkdir mntssd
```

### Step 4:
To mount the formatted drive with newly created directory, use the mount command
```
mount /dev/ssd mntssd
```
Now drive is available for use under mntssd directory

### Step 5:
Actually mounted drive will not be available once rebooted. To avoid this loss, it is needed to set mounted drive details on fstab config file. The following commands will help to setup the settings

1. cp /etc/fstab /etc/fstab.orig  (**backup the config file before change to avoid loss of original settings if any)
2. vi /etc/fstab
3. Add this line at the end: /dev/ssd    /mntssd        ext4    defaults    0 2
4. Save the file and exit the editor
5. Use “mount -a” command to verify the fstab settings added correctly. If any error, correct the fstab settings according to the error generated

That’s all!