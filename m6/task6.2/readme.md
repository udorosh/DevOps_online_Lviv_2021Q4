## Task 6.2

**1. Use already created internal-network for three VMs (VM1-VM3). VM1 has NAT and internal, VM2, VM3 – internal only interfaces.**

As i have DHCP server on VM1 and configured client on VM2, the only thing i need is to create a VM3 from VM2, here we go:
(https://github.com/udorosh/DevOps_online_Lviv_2021Q4/blob/master/m6/task6.2/screenshots/vboxes.png)

**2. Install and configure DHCP server on VM1.**

I have DHCP already. See the Task 6.1.

**3. Check VM2 and VM3 for obtaining network addresses from DHCP server.**

(https://github.com/udorosh/DevOps_online_Lviv_2021Q4/blob/master/m6/task6.2/screenshots/vm2-ip.png)

(https://github.com/udorosh/DevOps_online_Lviv_2021Q4/blob/master/m6/task6.2/screenshots/vm3-ip.png)

**4. Using existed network for three VMs (from p.1) install and configure DNS server on VM1. (You can use DNSMASQ, BIND9 or something else).**

Install bind9 DNS server
```commandline
$ sudo apt install bind9
```
Enable IPv4

`/etc/default/named`:
```commandline
OPTIONS="-u bind -4"
```
Enable DNS in ufw
```commandline
$ sudo ufw allow 53
$ sudo ufw reload
```

**5. Check VM2 and VM3 for gaining access to DNS server (naming services).**

(https://github.com/udorosh/DevOps_online_Lviv_2021Q4/blob/master/m6/task6.2/screenshots/vm2-dns.png)

(https://github.com/udorosh/DevOps_online_Lviv_2021Q4/blob/master/m6/task6.2/screenshots/vm3-dns.png)