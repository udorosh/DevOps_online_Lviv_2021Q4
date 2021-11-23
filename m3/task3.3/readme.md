## Task 3.3

### Configure EIGRP on routers
ISP1:
```commandline
en
conf t
router eigrp 1
network 10.95.12.0 0.0.0.255
network 22.3.95.0 0.0.0.63
exit
router eigrp 2 
network 10.95.12.0 0.0.0.255
network 22.3.95.64 0.0.0.63
exit
wr
```
ISP2:
```commandline
en
conf t
router eigrp 1
network 22.3.95.192 0.0.0.63
network 22.3.95.0 0.0.0.63
exit
router eigrp 3 
network 22.3.95.128 0.0.0.63
network 22.3.95.192 0.0.0.63
exit
wr
```
ISP3:
```commandline
en
conf t
router eigrp 2
network 3.95.12.0 0.0.0.255
network 22.3.95.64 0.0.0.64
exit
router eigrp 3 
network 22.3.95.128 0.0.0.63
network 3.95.12.0 0.0.0.255
exit
wr
```

### Scheme
(https://github.com/udorosh/DevOps_online_Lviv_2021Q4/blob/master/m3/task3.3/screenshots/3.3.jpg)
