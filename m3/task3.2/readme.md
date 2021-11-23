## Task 3.2

Add 3 empty routers and connect them.

Interface addresses are shown on the diagram.

### Router settings
ISP 1:
```commandline
en
conf t
int gi1/0
ip address 22.3.95.1 255.255.255.192
exit
int gi2/0
ip address 22.3.95.65 255.255.255.192
exit
int gi0/0
ip address 10.95.12.1 255.255.255.0
exit
wr
```
ISP 2:
```commandline
en
conf t
int gi1/0
ip address 22.3.95.2 255.255.255.192
exit
int gi3/0
ip address 22.3.95.129 255.255.255.192
exit
int gi0/0
ip address 22.3.95.193 255.255.255.192
exit
wr
```
ISP 3:
```commandline
en
conf t
int gi2/0
ip address 22.3.95.66 255.255.255.192
exit
int gi3/0
ip address 22.3.95.130 255.255.255.192
exit
int gi0/0.2
encapsulation dot1Q 2
ip address 3.95.12.1 255.255.255.192
exit
int gi0/0.3
encapsulation dot1Q 3
ip address 3.95.12.65 255.255.255.192
exit
int gi0/0.4
encapsulation dot1Q 4
ip address 3.95.12.129 255.255.255.192
exit
wr
```
Switch 1 (Data Center):
```commandline
en
conf t
int vlan 2
ip address 22.3.95.2 255.255.255.192
exit
int vlan 3
ip address 22.3.95.129 255.255.255.192
exit
int vlan 4
ip address 22.3.95.193 255.255.255.192
exit
int fa0/2
switchport mode access
switchport access vlan 2
exit
int fa0/3
switchport mode access
switchport access vlan 3
int fa0/4
switchport mode access
switchport access vlan 4
exit
int fa0/1
switchport mode trunk
switchport trunk allowed vlan 2-4
exit
wr
```

### Scheme
(https://github.com/udorosh/DevOps_online_Lviv_2021Q4/blob/master/m3/task3.2/screenshots/3.2.jpg)