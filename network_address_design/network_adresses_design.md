## Table of Contents

- [CIDR addresses](#CIDR-addresses)
- [Address Allocation](#Address-Allocation)

## <span style="color:red">CIDR addresses:</span>
* CIDR : 10.0.0.0/21
* Netmask: 255.255.248.0
* First Usable IP: 10.0.0.1
* Last Usable IP: 10.0.7.254
* Count: 2048

## <span style="color:red">Address Allocation</span>

### <span style="color:red">Availability Zone A</span>
+ <span style="color:red">Public Subnet-1:</span>
    + 10.0.0.0/24
    + Count: 256
    + First Usable IP: 10.0.0.1
    + Last Usable IP: 10.0.0.254
    + Netmask: 255.255.255.0


+ <span style="color:red">Private Subnet-1:</span>
    + 10.0.2.0/23
    + Count: 512
    + First Usable IP: 10.0.2.1
    + Last Usable IP: 10.0.3.254
    + Netmask: 255.255.254.0

### <span style="color:red">Availability Zone B</span>
+ <span style="color:red">Public Subnet 2:</span>
    + 10.0.1.0/24
    + Count: 256
    + First Usable IP: 10.0.1.1
    + Last Usable IP: 10.0.1.254
    + Netmask: 255.255.255.0


+ <span style="color:red">Private Subnet 2:</span>
    + 10.0.4.0/23
    + Count: 512
    + First Usable IP: 10.0.4.1
    + Last Usable IP: 10.0.5.254
    + Netmask: 255.255.254.0