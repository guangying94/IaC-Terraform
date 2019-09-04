# Introduction 
This repo is still work in progress, it contains sample for using Terraform to deploy various designs depending on the requirement.

## Details
The script leverages on Terraform module to define Azure resources.

Here's the modules built as of 4th Sep 2019.

#### Network
1. Azure Application Gateway
2. Application Security Group
3. Internal Load Balancer
4. Network Interface Card
5. Network Security Group
6. Public IP
7. Subnet

#### Compute
1. Linux VM
1. Windows VM

## Design Variation
1. Internet 3 Tier - For internet facing only application, with 3 tier architecture
![Internet3Tier](/assets/Internet-3-Tier.jpg)
1. Internet Zone - Internet section of a hybrid (Internet & Intranet) application
![Internet](/assets/Internet.jpg)
1. Intranet Zone - Intranet section of a hybrid (Internet & Intranet) application
![Intranet](/assets/Intranet.jpg)

## Diagram
Internet zone, with ASG and NSG configured. Please refer to nsg.xlsx for NSG rules configured.

![Internet](/assets/Internet.jpg)
