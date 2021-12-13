## Task 5.1

### Part 1
**1. Log in to the system as root.**
```commandline
$ sudo -i
[root@pc ~]#
```

**2. Use the passwd command to change the password. Examine the basic parameters of the command. What system file does it change?**
```commandline
[root@pc ~]# passwd user
New password: 
Retype new password: 
passwd: password updated successfully
```
`passwd` parameters:
```commandline
Options:
  -a, --all                     report password status on all accounts
  -d, --delete                  delete the password for the named account
  -e, --expire                  force expire the password for the named account
  -h, --help                    display this help message and exit
  -k, --keep-tokens             change password only if expired
  -i, --inactive INACTIVE       set password inactive after expiration
                                to INACTIVE
  -l, --lock                    lock the password of the named account
  -n, --mindays MIN_DAYS        set minimum number of days before password
                                change to MIN_DAYS
  -q, --quiet                   quiet mode
  -r, --repository REPOSITORY   change password in REPOSITORY repository
  -R, --root CHROOT_DIR         directory to chroot into
  -S, --status                  report password status on the named account
  -u, --unlock                  unlock the password of the named account
  -w, --warndays WARN_DAYS      set expiration warning days to WARN_DAYS
  -x, --maxdays MAX_DAYS        set maximum number of days before password
                                change to MAX_DAYS
```
`passwd` changes the /etc/shadow file which contains secure user account information.

It also uses `/etc/pam.d/passwd` and `/etc/passwd`.

**3. Determine the users registered in the system, as well as what commands they execute. What additional information can be gleaned from the command execution?**

The command is `cat /etc/passwd`

For example it contains: `user:x:1000:1000::/home/user:/bin/bash`

It means:

* there is a user named "user"
* user has password stored in `/etc/shadow`
* the UID and UID are `1000`
* home directory is `/home/user`
* user's shell is `/bin/bash`

**4. Change personal information about yourself.**

Changing the name (comment): `usermod -c "Yurii Dorosh" user`

Changing the groups: `usermod -G vboxusers,docker,video,audio,wheel,user user`

**5. Become familiar with the Linux help system and the man and info commands. Get help on the previously discussed commands, define and describe any two keys for these commands. Give examples.**

Getting help on usermod command: `usermod -i`. Getting man on usermod command: `man usermod`.

Example of command keys:
```commandline
-a, --append
           Add the user to the supplementary group(s). Use only with the -G
           option.

       -b, --badnames
           Allow names that do not conform to standards.
```
**6. Explore the more and less commands using the help system. View the contents of files `.bash*` using commands.**
```commandline
[root@pc ~]# more .bash*
...
[root@pc ~]# less .bash*
...
```

### Part 2
**1. Examine the tree command. Master the technique of applying a template, for example, display all files that contain a character c, or files that contain a specific sequence of characters. List subdirectories of the root directory up to and including the second nesting level.**
```commandline
[root@pc ~]# mkdir -p dir/dir/dir
[root@pc ~]# tree
.
├── dir
│   └── dir
│       └── dir
├── minicom.log
└── root
[root@pc ~]# touch dir/fdsfsdcdfsdf # with c
[root@pc ~]# touch dir/fdsfsdddfsdf # without c
[root@pc ~]# tree -P '*c*'
.
├── dir
│   ├── dir
│   │   └── dir
│   └── fdsfsdcdfsdf
├── minicom.log
└── root

4 directories, 2 files
[root@pc ~]# 
```

**2. What command can be used to determine the type of file (for example, text or binary)? Give an example.**

The command is `file`.
```commandline
[root@pc ~]# file dir/filename
dir/filename: empty
[root@pc ~]# echo "text" > dir/filename
[root@pc ~]# file dir/filename 
dir/filename: ASCII text
```

**3. Master the skills of navigating the file system using relative and absolute paths. How can you go back to your home directory from anywhere in the filesystem?**

There are several ways to go to the home directory:
* `cd $HOME`
* `cd ~`
* `cd`

**4. Become familiar with the various options for the ls command. Give examples of listing directories using different keys. Explain the information displayed on the terminal using the -l and -a switches.**

`-a` parameter displays hidden files named starting from dot. `-l` parameter display list with such information:

* permissions
* number of links
* owner name
* owner group
* file size
* time of last modification
* name

```commandline
[root@pc ~]# ls -la
total 96
drwxr-x--- 15 root root  4096 Dec 03 21:30 .
drwxr-xr-x 17 root root  4096 May 25  2021 ..
-rw-------  1 root root 19338 Dec 03 21:24 .bash_history
drwxr-xr-x  7 root root  4096 Dec 12  2020 .cache
drwx------ 14 root root  4096 Oct 01 18:27 .config
drwxr-x---  3 root root  4096 Dec 02  2020 .ddccontrol
drwxr-xr-x  3 root root  4096 Dec 03 21:33 dir
drwx------  3 root root  4096 Sep 20  2020 .gnupg
drwxr-xr-x  3 root root  4096 Sep 27  2020 .local
-rw-r--r--  1 root root    35 Apr 28  2021 minicom.log
drwxr-xr-x  3 root root  4096 Sep 18 17:35 .npm
drwx------  3 root root  4096 Sep 27  2020 .pki
drwxr-x--- 11 root root  4096 Oct 27  2020 root
drwx------  2 root root  4096 Jan 17  2021 .ssh
-rw-r--r--  1 root root   253 Dec 03 14:48 .wget-hsts
```

**5. Perform the following sequence of operations:**
* **create a subdirectory in the home directory**
* **in this subdirectory create a file containing information about directories located in the root directory (using I/O redirection operations)**
* **view the created file**
* **copy the created file to your home directory using relative and absolute addressing**
* **delete the previously created subdirectory with the file requesting removal**
* **delete the file copied to the home directory**
```commandline
[root@pc ~]# mkdir subdirectory
[root@pc ~]# touch subdirectory/file
[root@pc ~]# tree -d > subdirectory/file
[root@pc ~]# cat subdirectory/file 
.
├── dir
│   └── dir
│       └── dir
├── root
└── subdirectory

5 directories
[root@pc ~]# cp subdirectory/file .
[root@pc ~]# cp subdirectory/file /root/
[root@pc ~]# cp subdirectory/file /root
[root@pc ~]# rm -ir subdirectory/
rm: descend into directory 'subdirectory/'? y
rm: remove regular file 'subdirectory/file'? y
rm: remove directory 'subdirectory/'? y
[root@pc ~]# rm file 
```
**6. Perform the following sequence of operations:**
- **create a subdirectory test in the home directory**
- **copy the .bash_history file to this directory while changing its name to labwork2**
- **create a hard and soft link to the labwork2 file in the test subdirectory**
- **how to define soft and hard link, what do these concepts**
- **change the data by opening a symbolic link. What changes will happen and why**
- **rename the hard link file to hard_lnk_labwork2**
- **rename the soft link file to symb_lnk_labwork2 file**
- **then delete the labwork2. What changes have occurred and why**
```commandline
[root@pc ~]# mkdir test
[root@pc ~]# cp .bash_history test/labwork2
[root@pc ~]# ln test/labwork2 test/labwork2_hard
[root@pc ~]# ln -s labwork2 test/labwork2_soft
```

Soft link can be defined with file command and hard link will be just a file. Hard link is another name for file stored in file system; soft link is a file which links to another file.
```commandline
[root@pc ~]# file test/labwork2_hard
test/labwork2_hard: Unicode text, UTF-8 text
[root@pc ~]# file test/labwork2_soft 
test/labwork2_soft: symbolic link to labwork2
```

While changing the data by opening soft link the data in target file will be changed:
```commandline
[root@pc ~]# echo "test" > test/labwork2_soft 
[root@pc ~]# cat test/labwork2
test
```

```commandline
[root@pc ~]# mv test/labwork2_hard test/hard_lnk_labwork2
[root@pc ~]# mv test/labwork2_soft test/symb_lnk_labwork2
```

When deleting the `labwork2` file hard link is still reffered to same data in file system, but soft link now refers to non-existing file.
```commandline
[root@pc ~]# rm test/labwork2 
[root@pc ~]# ls -l test/symb_lnk_labwork2
lrwxrwxrwx 1 root root 8 Dec 13 21:49 test/symb_lnk_labwork2 -> labwork2
[root@pc ~]# cat test/symb_lnk_labwork2
cat: test/symb_lnk_labwork2: No such file or directory
[root@pc ~]# cat test/hard_lnk_labwork2
test
```

**7. Using the locate utility, find all files that contain the squid and traceroute sequence.**

...

**8. Determine which partitions are mounted in the system, as well as the types of these partitions.**

Mounted partitions with types:
```commandline
$ mount
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
sys on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
dev on /dev type devtmpfs (rw,nosuid,relatime,size=16349328k,nr_inodes=4087332,mode=755,inode64)
run on /run type tmpfs (rw,nosuid,nodev,relatime,mode=755,inode64)
efivarfs on /sys/firmware/efi/efivars type efivarfs (rw,nosuid,nodev,noexec,relatime)
/dev/sda2 on / type ext4 (rw,relatime)
securityfs on /sys/kernel/security type securityfs (rw,nosuid,nodev,noexec,relatime)
tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev,inode64)
devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000)
cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursiveprot)
pstore on /sys/fs/pstore type pstore (rw,nosuid,nodev,noexec,relatime)
none on /sys/fs/bpf type bpf (rw,nosuid,nodev,noexec,relatime,mode=700)
systemd-1 on /proc/sys/fs/binfmt_misc type autofs (rw,relatime,fd=30,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=20138)
hugetlbfs on /dev/hugepages type hugetlbfs (rw,relatime,pagesize=2M)
mqueue on /dev/mqueue type mqueue (rw,nosuid,nodev,noexec,relatime)
debugfs on /sys/kernel/debug type debugfs (rw,nosuid,nodev,noexec,relatime)
tracefs on /sys/kernel/tracing type tracefs (rw,nosuid,nodev,noexec,relatime)
tmpfs on /tmp type tmpfs (rw,nosuid,nodev,size=16356872k,nr_inodes=409600,inode64)
configfs on /sys/kernel/config type configfs (rw,nosuid,nodev,noexec,relatime)
binfmt_misc on /proc/sys/fs/binfmt_misc type binfmt_misc (rw,nosuid,nodev,noexec,relatime)
fusectl on /sys/fs/fuse/connections type fusectl (rw,nosuid,nodev,noexec,relatime)
/dev/sdb1 on /mnt/8664818a-863b-491f-af74-3a976a33c843 type ext4 (rw,nosuid,nodev,relatime,x-gvfs-show)
/dev/sda1 on /boot type vfat (rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,utf8,errors=remount-ro)
/dev/sdc1 on /home type ext4 (rw,relatime)
tmpfs on /run/user/1000 type tmpfs (rw,nosuid,nodev,relatime,size=3271372k,nr_inodes=817843,mode=700,uid=1000,gid=1000,inode64)
gvfsd-fuse on /run/user/1000/gvfs type fuse.gvfsd-fuse (rw,nosuid,nodev,relatime,user_id=1000,group_id=1000)
portal on /run/user/1000/doc type fuse.portal (rw,nosuid,nodev,relatime,user_id=1000,group_id=1000)
```

It can also be done using `df` command:
```commandline
$ df -h
df: /run/user/1000/doc: Operation not permitted
Filesystem      Size  Used Avail Use% Mounted on
dev              16G     0   16G   0% /dev
run              16G  2.3M   16G   1% /run
/dev/sda2        73G   68G  1.2G  99% /
tmpfs            16G  201M   16G   2% /dev/shm
tmpfs            16G   27M   16G   1% /tmp
/dev/sdb1       916G  506G  364G  59% /mnt/8664818a-863b-491f-af74-3a976a33c843
/dev/sda1       119M   79M   40M  67% /boot
/dev/sdc1       905G  840G   19G  98% /home
tmpfs           3.2G   48K  3.2G   1% /run/user/1000
```

**9. Count the number of lines containing a given sequence of characters in a given file.**
```commandline
$ wc -l devicetree.dts 
17946 devicetree.dts
```

**10. Using the find command, find all files in the `/etc` directory containing the host character sequence.**
```commandline
$ sudo find /etc -type f -name "*host*"
/etc/distcc/hosts
/etc/ssh/ssh_host_ecdsa_key.pub
/etc/ssh/ssh_host_rsa_key.pub
/etc/ssh/ssh_host_ed25519_key
/etc/ssh/ssh_host_ecdsa_key
/etc/ssh/ssh_host_dsa_key.pub
/etc/ssh/ssh_host_rsa_key
/etc/ssh/ssh_host_ed25519_key.pub
/etc/ssh/ssh_host_dsa_key
/etc/hosts
/etc/openmpi/openmpi-default-hostfile
/etc/avahi/hosts
/etc/host.conf
/etc/ImageMagick-7/type-ghostscript.xml
/etc/hostname
```

**11. List all objects in /etc that contain the ss character sequence. How can I duplicate a similar command using a bunch of grep?**
```commandline
$ ls -l /etc | grep ss
-rw-r--r--  1 root root     10 Dec  7 04:41 issue
-rw-r--r--  1 root root    359 Nov 27 04:41 nsswitch.conf
-rw-r--r--  1 root root   3336 Dec 03 21:21 passwd
-rw-r--r--  1 root root   3323 Nov 23 10:02 passwd-
-rw-r--r--  1 root root   1597 Nov 16  2020 passwd.OLD
drwxr-xr-x  2 root root   4096 Dec 13 07:23 ssh
drwxr-xr-x  5 root root   4096 Dec 13 07:22 ssl
```

**12. Organize a screen-by-screen print of the contents of the `/etc directory`. Hint: You must use stream redirection operations.**
```commandline
$ ls -l /etc | less
```

**13. What are the types of devices and how to determine the type of device? Give examples.**

Linux supports character and block devices:
```commandline
$ ls -l /dev | grep ^c | head -5 # character devices
crw-r--r--   1 root root       10, 235 Dec 13 11:46 autofs
crw-------   1 root root       10, 234 Dec 13 11:46 btrfs-control
crw-------   1 root root        5,   1 Dec 13 11:47 console
crw-------   1 root root       10,  60 Dec 13 11:46 cpu_dma_latency
crw-------   1 root root       10, 203 Dec 13 11:46 cuse
$ ls -l /dev | grep ^b | head -5 # block devices
brw-rw----   1 root disk        8,   0 Dec 13 11:46 sda
brw-rw----   1 root disk        8,   1 Dec 13 11:46 sda1
brw-rw----   1 root disk        8,   2 Dec 13 11:46 sda2
brw-rw----   1 root disk        8,  16 Dec 13 11:46 sdb
brw-rw----   1 root disk        8,  17 Dec 13 11:46 sdb1
```

**14. How to determine the type of file in the system, what types of files are there?**

We can determine the type of file using `file` command:
```commandline
$ file client-103.246.146.101.ovpn 
client-103.246.146.101.ovpn: ASCII text
$ file /dev/sda
/dev/sda: block special (8/0)
```

There are seven types of files: normal files (-), block (b), character(c), symbolic links (l), pipes (p), sockets (s) and directories (d).

**15.** * **List the first 5 directory files that were recently accessed in the /etc directory.**
```commandline
$ ls -ltu /etc | grep ^d | head -5
drwx------  3 root root   4096 Dec 13 01:43 cni
drwxr-xr-x  2 root root   4096 Dec 13 01:42 bash_completion.d
drwxr-xr-x  2 root root   4096 Dec 13 01:42 cifs-utils
drwxr-xr-x  2 root root   4096 Dec 13 01:42 default
drwxr-xr-x  2 root root   4096 Dec 13 01:42 dkms
```