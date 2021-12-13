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