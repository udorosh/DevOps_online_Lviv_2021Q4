   ## Task 2.1

### Part 1 - Hypervisors

**Hypervisors Type 1**

- VMware vSphere

VMware vSphere includes the ESXi hypervisor and vCenter management software to provide a suite of virtualization products, such as the vSphere Client, vSphere software development kits, Storage vMotion, the Distributed Resource Scheduler and Fault Tolerance. VMware vSphere is geared toward enterprise data centers; smaller businesses might find it difficult to justify the price.

- Microsoft Hyper-V

Microsoft Hyper-V runs on Windows OSes and enables admins to run multiple OSes inside a VM. Admins and developers often use Hyper-V to build test environments to run software on several OSes by creating VMs for each test.

- KVM

The KVM hypervisor is an open source virtualization architecture made for Linux distributions. The KVM hypervisor enables admins to convert a Linux kernel into a hypervisor and has direct access to hardware along with any VMs hosted by the hypervisor. Features include live migration, scheduling and resource control.

**Hypervisors Type 2**

- Oracle VM VirtualBox

Oracle VM VirtualBox is an open source hosted hypervisor that runs on a host OS to support guest VMs. VirtualBox supports a variety of host OSes, such as Windows, Apple macOS, Linux and Oracle Solaris. VirtualBox offers multigeneration branched snapshots, Guest Additions, guest multiprocessing, ACPI support and Preboot Execution Environment network boot.

- VMware Workstation Pro and VMware Fusion

VMware Workstation Pro is a 64-bit hosted hypervisor capable of implementing virtualization on Windows and Linux systems. Some of Workstation's features include host/guest file sharing, the creation and deployment of encrypted VMs, and VM snapshots.

VMware developed Fusion as an alternative to Workstation. VMware Fusion offers many of the same capabilities as Workstation but is macOS compatible and comes with fewer features at a reduced price.

- QEMU

QEMU is an open source virtualization tool that emulates CPU architectures and enables developers and admins to run applications compiled for one architecture on another. QEMU offers features such as support for non-volatile dual in-line memory module hardware, share file system, secure guests and memory encryption.

**Difference between Type 1 and Type 2**

When choosing between a Type 1 and Type 2 hypervisor, admins must consider the type and size of their workloads. If admins primarily work in an enterprise or large organization and must deploy hundreds of VMs, a Type 1 hypervisor will suit their needs.

But if admins have a smaller deployment or require a testing environment, Type 2 hypervisors are less complex and have a smaller price tag. And enterprises and organizations can use Type 2 hypervisors as needed for workloads that suit the technology.

### Part 2 - Work with VirtualBox

Creating VM, SATA controller, HDD and DVD with Ubuntu image, configure parameters and network.
```commandline
VBoxManage createvm --name Ubuntu-20.04_Dorosh --ostype Ubuntu_64 --register --basefolder /media/udorosh/Data/VMs
```
```commandline
VBoxManage modifyvm Ubuntu-20.04_Dorosh --cpus 2 --memory 2048 --vram 256 --nic1 bridged --bridgeadapter1 eth0
```
```commandline
VBoxManage storagectl Ubuntu-20.04_Dorosh --name "SATA Controller" --add sata --bootable on
```
```commandline
VBoxManage createmedium disk --filename /media/udorosh/Data/VMs/Ubuntu-20.04_Dorosh/ubuntu_disk1.vdi --size 10240 --format VDI --variant Standard
```
```commandline
VBoxManage storageattach Ubuntu-20.04_Dorosh --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium /media/udorosh/Data/VMs/Ubuntu-20.04_Dorosh/ubuntu_disk1.vdi
```
```commandline
VBoxManage storageattach Ubuntu-20.04_Dorosh --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium /home/udorosh/Downloads/ubuntu-20.04.3-desktop-amd64.iso
```
```commandline
VBoxManage startvm Ubuntu-20.04_Dorosh
```

Possibilities of VM control
```commandline
VBoxManage startvm Ubuntu-20.04_Dorosh
```
```commandline
VBoxManage controlvm Ubuntu-20.04_Dorosh pause
```
```commandline
VBoxManage controlvm Ubuntu-20.04_Dorosh resume
```
```commandline
VBoxManage controlvm Ubuntu-20.04_Dorosh reset
```
```commandline
VBoxManage controlvm Ubuntu-20.04_Dorosh savestate
```
```commandline
VBoxManage startvm Ubuntu-20.04_Dorosh
```
```commandline
VBoxManage controlvm Ubuntu-20.04_Dorosh poweroff
```
```commandline
VBoxManage controlvm Ubuntu-20.04_Dorosh clipboard mode bidirectional
```
```commandline
VBoxManage controlvm Ubuntu-20.04_Dorosh draganddrop bidirectional
```

Clone VM, export-import, use USB mapping and SharedFolder mapping.
```commandline
VBoxManage clonevm Ubuntu-20.04_Dorosh --basefolder=/media/udorosh/Data/VMs --mode=machine --name=VM2 --register
```
```commandline
VBoxManage modifyvm Ubuntu-20.04_Dorosh --name Ubuntu-20.04_Dorosh_1
```
```commandline
VBoxManage modifyvm VM2 --name Ubuntu-20.04_Dorosh_2
```
```commandline
VBoxManage modifyvm Ubuntu-20.04_Dorosh_1 --groups "/MyFirstGroup"
```
```commandline
VBoxManage modifyvm Ubuntu-20.04_Dorosh_2 --groups "/MyFirstGroup"
```
```commandline
VBoxManage snapshot Ubuntu-20.04_Dorosh_1 take snapshot-2021-11-10_18-42
```
```commandline
VBoxManage snapshot Ubuntu-20.04_Dorosh_1 take snapshot-2021-11-10_18-54
```
```commandline
VBoxManage export Ubuntu-20.04_Dorosh_1 -o /media/udorosh/Data/VMs/Ubuntu-20.04_Dorosh_1.ova
```
```commandline
VBoxManage import /media/udorosh/Data/VMs/Ubuntu-20.04_Dorosh_1.ova
```

Connect shared folder to VM. But previously we must install vbox additions with following command
```commandline
sudo apt install virtualbox-guest-additions-iso
```
and then connect a shared folder
```commandline
VBoxManage sharedfolder add Ubuntu-20.04_Dorosh_1 --name=SFolder --hostpath=/home/udorosh/Downloads --automount --auto-mount-point=SFolder
```
```commandline
mkdir /home/udorosh/vboxshare
```
```commandline
sudo mount -t vboxsf -o uid=1000,gid=1000 SFolder /home/udorosh/vboxshare
```

Change of network configuration
```commandline
VBoxManage modifyvm Ubuntu-20.04_Dorosh_1 --nic1 nat
```

Check the network connection parameters

before
```commandline
ip a
```
and after
```commandline
ping 8.8.8.8
```
