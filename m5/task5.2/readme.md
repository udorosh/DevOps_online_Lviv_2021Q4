##Task 5.2

**1. Analyze the structure of the /etc/passwd and /etc/group file, what fields are present in it, what users exist on the system? Specify several pseudo-users, how to define them?**

For example it contains: `user:x:1000:1000::/home/user:/bin/bash`
It means:

* there is a user named "user"
* user has password stored in `/etc/shadow`
* the UID and GID are `1000`
* home directory is `/home/user`
* user's shell is `/bin/bash`

**2. What are the uid ranges? What is UID? How to define it?**

UID is the user identificator. To check the UID we can use `id` command:
```commandline
$ id user
uid=1000(user) gid=1000(user) groups=1000(user),108(vboxusers),977(docker),986(video),995(audio),998(wheel)
```
UID ranges:
* UID 0 (zero) is reserved for the root.
* 1…999 → System users. These are users that do not map to actual “human” users, but are used as security identities for system daemons, to implement privilege separation and run system daemons with minimal privileges.
* 65534 → The nobody UID, also called the “overflow” UID or similar.
* 65535, aka “16bit (uid_t) -1” → Before Linux kernel 2.4 uid_t used to be 16bit, and programs compiled for that would hence assume that (uid_t) -1 is 65535. This UID is hence not usable either.
* 1000…65533 and 65536…4294967294 → Everything else, i.e. regular (human) users.

UID ranges may vary from a distribution to distribution and can be changed in `/etc/login.defs`.

We can change the UID of the user using this command: `usermod -u 1002 user`.
Then we should update the owning files to support the new user: `find / -uid 1000 -exec chown -v -h 900 '{}' \`

**3. What is GID? How to define it?**

GID is the group identifier. Like UID, GID 0 is reserved for root group, the first 100 UIDs are reserved for system use.

Changing GID for `group01` group: `groupmod -g 600 group01`. Then change owning files: `find / -gid 700 -exec chgrp -v 600 '{}' \`

**4. How to determine belonging of user to the specific group?**

The commands are `id username` and `groups username`.

**5. What are the commands for adding a user to the system? What are the basic parameters required to create a user?**

The command are `useradd` and `adduser` utilities. `adduser` is user-friendly utility for Debian/Ubuntu, `useradd` is more low level.

Here are some important parameters for `useradd`:

* -G - specify groups
* -m - create home directory
* -d - specify home directory
* -u - specify UID
* -g - specify specific initial login group
* -s - specify shell

**6. How do I change the name (account name) of an existing user?**

Renaming user:

* with username: `usermod -l new-name old-name`
* with UID: `usermod -u UID new-name`

**7. What is skell_dir? What is its structure?**

skell_dir is used to generate a new home directory for user. It's `/etc/skell` by default, but can be changed in the `/etc/default/useradd`.

**8. How to remove a user from the system (including his mailbox)?**

User can be deleted using `userdel` command. For example, to delete a user, their home directory and their mailbox `userdel -r username`. Note that all user's process must be stopped, otherwise use `-f (--force)` parameter.

**9. What commands and keys should be used to lock and unlock a user account?**

There are two ways to lock user from command line:

* passwd -l username
* usermod -l username

As well as two ways to unlock:

* passwd -u username
* usermod -U username

**10. How to remove a user password and provide him with a password-free login for subsequent password change?**

The command is `userdel -d username`.