## Task 6.1

**1. Create virtual machines connection according to image**
![figure1](https://github.com/udorosh/DevOps_online_Lviv_2021Q4/blob/master/m6/task6.1/screenshots/figure1.png)


**2. VM2 has one interface (internal), VM1 has 2 interfaces (NAT and internal). Configure all network interfaces in order to make VM2 has an access to the Internet (iptables, forward, masquerade).**

`VM1 - Adapter 1 (NAT)`
![vm1-adapter1](https://github.com/udorosh/DevOps_online_Lviv_2021Q4/blob/master/m6/task6.1/screenshots/vm1-adapter1.png)

`VM1 - Adapter 2 (internal)`
![vm1-adapter2](https://github.com/udorosh/DevOps_online_Lviv_2021Q4/blob/master/m6/task6.1/screenshots/vm1-adapter2.png)

`VM2 - Adapter 1 (internal)`
![vm2-adapter1](https://github.com/udorosh/DevOps_online_Lviv_2021Q4/blob/master/m6/task6.1/screenshots/vm2-adapter1.png)

`VM1 - interfaces`
![vm1-interfaces](https://github.com/udorosh/DevOps_online_Lviv_2021Q4/blob/master/m6/task6.1/screenshots/vm1-interfaces.png)

`VM2 - interfaces`
![vm2-interfaces](https://github.com/udorosh/DevOps_online_Lviv_2021Q4/blob/master/m6/task6.1/screenshots/vm2-interfaces.png)

To complete this task properly I want to set up DHCP server and make the configuration persistent after reboot, so I use isc-dhcp-server and netplan.

### VM 1 - Setting up DHCP
Before setting up DHCP server I need to assign an ip address to enp0s8 on VM1.
`/etc/netplan/enp8s0-ip.yaml`:
```commandline
network:
  version: 2
  ethernets:
    enp0s8:
     dhcp4: no
     addresses: [192.168.5.1/24]
```
Applying the configuration:
```commandline
$ sudo netplan apply
```
Installing DHCP server on VM1:
```commandline
$ sudo apt install isc-dhcp-server
```
My `/etc/dhcp/dhcpd.conf` config:
```commandline
default-lease-time 600;
max-lease-time 7200;
authoritative;
 
subnet 192.168.5.0 netmask 255.255.255.0 {
 range 192.168.5.100 192.168.5.200;
 option routers 192.168.5.1;
 option domain-name-servers 192.168.5.1, 192.168.5.2;
}
```
So, now attaching DHCP server to network interface in `/etc/default/isc-dhcp-server`:
```commandline
INTERFACESv4="enp0s8"
```

### VM 2 - Setting up DHCP client and gateway
`/etc/netplan/enp3s0.yaml`:
```commandline
network:
  version: 2
  ethernets:
    enp3s0: 
      dhcp4: true
```
**Note:** default gateway is set using DHCP, see routes at isc-dhcp-server config.

### VM 1 - Allow forwarding
`/etc/sysctl.conf`:
```commandline
net.ipv4.ip_forward=1
```
Applying the change:
```commandline
$ sudo sysctl -p
```

### VM 1 - Set up forwarding
To make it persistent after reboot i decided to use `ufw`:
```commandline
$ sudo apt install ufw
```
`/etc/default/ufw`:
```commandline
DEFAULT_FORWARD_POLICY="ACCEPT"
```
`/etc/ufw/before.rules`:
```commandline
...

*nat
:POSTROUTING ACCEPT [0:0]
-A POSTROUTING -s 192.168.5.0/24 -o enp0s3 -j MASQUERADE
COMMIT
```
```commandline
$ sudo ufw enable
```

**3. Check the route from VM2 to Host.**
![routing-to-host](https://github.com/udorosh/DevOps_online_Lviv_2021Q4/blob/master/m6/task6.1/screenshots/routing-to-host.png)


**4. Check the access to the Internet, (just ping, for example, 8.8.8.8).**
![ping](https://github.com/udorosh/DevOps_online_Lviv_2021Q4/blob/master/m6/task6.1/screenshots/ping.png)


**5. Determine, which resource has an IP address 8.8.8.8.**

8.8.8.8 is owned by Google LLC.

```commandline
$ whois 8.8.8.8

#
# ARIN WHOIS data and services are subject to the Terms of Use
# available at: https://www.arin.net/resources/registry/whois/tou/
#
# If you see inaccuracies in the results, please report at
# https://www.arin.net/resources/registry/whois/inaccuracy_reporting/
#
# Copyright 1997-2021, American Registry for Internet Numbers, Ltd.
#



# start

NetRange:       8.0.0.0 - 8.127.255.255
CIDR:           8.0.0.0/9
NetName:        LVLT-ORG-8-8
NetHandle:      NET-8-0-0-0-1
Parent:         NET8 (NET-8-0-0-0-0)
NetType:        Direct Allocation
OriginAS:       
Organization:   Level 3 Parent, LLC (LPL-141)
RegDate:        1992-12-01
Updated:        2018-04-23
Ref:            https://rdap.arin.net/registry/ip/8.0.0.0



OrgName:        Level 3 Parent, LLC
OrgId:          LPL-141
Address:        100 CenturyLink Drive
City:           Monroe
StateProv:      LA
PostalCode:     71203
Country:        US
RegDate:        2018-02-06
Updated:        2021-09-23
Comment:        ADDRESSES WITHIN THIS BLOCK ARE NON-PORTABLE ANY ISP ANNOUNCING OR TRANSITING PORTIONS WITHIN OUR RANGES SHOULD NOT RELY ON PRESENTED LOA'S UNLESS THOSE RANGES ARE ALSO ANNOUNCED TO A LUMEN ASN. 
Comment:        
Comment:        Our looking glass is located at: https://lookingglass.centurylink.com/
Comment:        
Comment:        For subpoena or court order please fax 844.254.5800 or refer to our Trust & Safety page:
Comment:        https://www.lumen.com/en-us/about/legal/trust-center/trust-and-safety.html
Comment:        
Comment:        For abuse issues, please email abuse@aup.lumen.com
Comment:        All abuse reports MUST include: 
Comment:        * src IP 
Comment:        * dest IP (your IP) 
Comment:        * dest port 
Comment:        * Accurate date/timestamp and timezone of activity 
Comment:        * Intensity/frequency (short log extracts) 
Comment:        * Your contact details (phone and email) 
Comment:        Without these we will be unable to identify the correct owner of the IP address at that point in time.
Ref:            https://rdap.arin.net/registry/entity/LPL-141


OrgAbuseHandle: LAC56-ARIN
OrgAbuseName:   L3 Abuse Contact
OrgAbusePhone:  +1-877-453-8353 
OrgAbuseEmail:  abuse@level3.com
OrgAbuseRef:    https://rdap.arin.net/registry/entity/LAC56-ARIN

OrgTechHandle: IPADD5-ARIN
OrgTechName:   ipaddressing
OrgTechPhone:  +1-877-453-8353 
OrgTechEmail:  ipaddressing@level3.com
OrgTechRef:    https://rdap.arin.net/registry/entity/IPADD5-ARIN

# end


# start

NetRange:       8.8.8.0 - 8.8.8.255
CIDR:           8.8.8.0/24
NetName:        LVLT-GOGL-8-8-8
NetHandle:      NET-8-8-8-0-1
Parent:         LVLT-ORG-8-8 (NET-8-0-0-0-1)
NetType:        Reallocated
OriginAS:       
Organization:   Google LLC (GOGL)
RegDate:        2014-03-14
Updated:        2014-03-14
Ref:            https://rdap.arin.net/registry/ip/8.8.8.0



OrgName:        Google LLC
OrgId:          GOGL
Address:        1600 Amphitheatre Parkway
City:           Mountain View
StateProv:      CA
PostalCode:     94043
Country:        US
RegDate:        2000-03-30
Updated:        2019-10-31
Comment:        Please note that the recommended way to file abuse complaints are located in the following links. 
Comment:        
Comment:        To report abuse and illegal activity: https://www.google.com/contact/
Comment:        
Comment:        For legal requests: http://support.google.com/legal 
Comment:        
Comment:        Regards, 
Comment:        The Google Team
Ref:            https://rdap.arin.net/registry/entity/GOGL


OrgAbuseHandle: ABUSE5250-ARIN
OrgAbuseName:   Abuse
OrgAbusePhone:  +1-650-253-0000 
OrgAbuseEmail:  network-abuse@google.com
OrgAbuseRef:    https://rdap.arin.net/registry/entity/ABUSE5250-ARIN

OrgTechHandle: ZG39-ARIN
OrgTechName:   Google LLC
OrgTechPhone:  +1-650-253-0000 
OrgTechEmail:  arin-contact@google.com
OrgTechRef:    https://rdap.arin.net/registry/entity/ZG39-ARIN

# end



#
# ARIN WHOIS data and services are subject to the Terms of Use
# available at: https://www.arin.net/resources/registry/whois/tou/
#
# If you see inaccuracies in the results, please report at
# https://www.arin.net/resources/registry/whois/inaccuracy_reporting/
#
# Copyright 1997-2021, American Registry for Internet Numbers, Ltd.
#
```

**6. Determine, which IP address belongs to resource epam.com.**

epam.com belongs to 3.214.134.159 ip address.

```commandline
$ dig epam.com

; <<>> DiG 9.16.23 <<>> epam.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 20841
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 6, ADDITIONAL: 6

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;epam.com.			IN	A

;; ANSWER SECTION:
epam.com.		2686	IN	A	3.214.134.159

;; AUTHORITY SECTION:
epam.com.		77500	IN	NS	a7-64.akam.net.
epam.com.		77500	IN	NS	a14-66.akam.net.
epam.com.		77500	IN	NS	a20-67.akam.net.
epam.com.		77500	IN	NS	a1-195.akam.net.
epam.com.		77500	IN	NS	a11-65.akam.net.
epam.com.		77500	IN	NS	a10-64.akam.net.

;; ADDITIONAL SECTION:
a7-64.akam.net.		156384	IN	A	23.61.199.64
a1-195.akam.net.	63452	IN	A	193.108.91.195
a11-65.akam.net.	162643	IN	A	84.53.139.65
a14-66.akam.net.	169073	IN	A	184.26.161.66
a20-67.akam.net.	59890	IN	A	95.100.175.67

;; Query time: 0 msec
;; SERVER: 192.168.1.1#53(192.168.1.1)
;; WHEN: Sat Jan 15 14:40:42 EET 2022
;; MSG SIZE  rcvd: 266
```

**7. Determine the default gateway for your HOST and display routing table.**

Default gateway:
```commandline
$  ip route | grep default
default via 192.168.1.1 dev enp6s0 proto dhcp metric 100
```
Routing table:
```commandline
$ route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.1.1     0.0.0.0         UG    100    0        0 enp6s0
172.17.0.0      0.0.0.0         255.255.0.0     U     0      0        0 docker0
172.18.0.0      0.0.0.0         255.255.0.0     U     0      0        0 br-15e5c6ac197a
192.168.1.0     0.0.0.0         255.255.255.0   U     100    0        0 enp6s0
```

**8. Trace the route to google.com.**
```commandline
$ traceroute google.com
traceroute to google.com (142.250.180.206), 30 hops max, 60 byte packets
 1  _gateway (192.168.1.1)  0.387 ms  0.380 ms  0.443 ms
 2  10.100.126.1 (10.100.126.1)  9.550 ms  9.583 ms  9.476 ms
 3  border-gw.best.net.ua (95.158.0.213)  1.269 ms  1.212 ms  0.974 ms
 4  google-peer-google.best.net.ua (95.158.0.154)  1.587 ms  1.790 ms  1.667 ms
 5  108.170.248.138 (108.170.248.138)  8.791 ms 108.170.248.155 (108.170.248.155)  8.780 ms  8.768 ms
 6  142.251.67.218 (142.251.67.218)  15.453 ms  15.183 ms  15.335 ms
 7  142.251.77.181 (142.251.77.181)  22.601 ms 74.125.242.241 (74.125.242.241)  14.612 ms  14.607 ms
 8  74.125.242.225 (74.125.242.225)  15.899 ms 142.251.65.227 (142.251.65.227)  14.777 ms 142.251.65.225 (142.251.65.225)  14.595 ms
 9  bud02s33-in-f14.1e100.net (142.250.180.206)  14.572 ms  14.666 ms  14.605 ms
```
