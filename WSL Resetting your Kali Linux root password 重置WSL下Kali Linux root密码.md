重置WSL下Kali Linux root密码

[toc]

## Open CMD

       C:\> kali config --default-user root 

## ReLaunch your Linux distribution (kali). You will automatically login as root:

then Reset your password using the passwd command:

    passwd root 

## From Windows CMD, reset your default user back to your normal Linux user account.

`   C :\> kali config --default-user "xiaohan"`

