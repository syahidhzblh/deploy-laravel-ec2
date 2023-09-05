# Guide to Deploy Laravel Starter on AWS EC2

In this section i will show how to deploy Laravel Starter on AWS EC2

# Laravel Starter (based on Laravel 10.x) from Nasir Khan Saikat

For this project i used Sample App Laravel Starter from Nasir Khan Saikat to Deploy on AWS EC2
you can find this project on `https://github.com/nasirkhan/laravel-starter.git`

# Deployment Step

## Create Instance on AWS EC2

1. Go to your AWS Console, then open the EC2 Instance.
2. Create new Instance, you can find on Launch Instance Button.
3. On this section i use Free Tier Spec:

- Operating System : Ubuntu 22.04 LTS
- Instance Type : t2.micro
- Storage : 8 GB
- Port Allow Needed : 22 (SSH), 80(HTTP), 433(HTTPS), 8000(Optional Laravel Port)

4. Create or use existing keypair for SSH Remote.
5. For the Network Setting, you can use default VPC or your own VPC.
6. Create Security Group, for allow Port 22, 80, 8000, and 433. On this section i use security group was i already created, i give name `WebServer`
7. To shorten the time, on this section i use metadata was i created on this Repository.
8. Click Advanced Details, go to Metadata Section and drop it metadata-laravel config into it.
9. Review Instance on Summary, made sure all the spec and config already correct. Choose Launch Instance.
10. After instance succesfully created, check on your instance EC2 dashboard. Make sure instance running and status check passed.

## Metadata Explanation

```bash
#!/bin/bash
apt update -y && apt upgrade -y
timedatectl set-timezone Asia/Jakarta
apt install -y nginx
apt install -y git
apt install -y php-cli php-xml php-curl php-zip php-mbstring php-dom php8.1-mysql php8.1-fpm php-bcmath
apt install -y mariadb-server
curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -
apt install -y nodejs
systemctl start nginx
service php8.1-fpm start
```

1. Update and Upgrade package linux
2. Set Timezone to your Region (You can replace with your region)
3. Install Nginx
4. Install Git
5. Install PHP 8.1 and other extension
6. Install MariaDB
7. Set Package Repo for Install NodeJS Version 16.x
8. Start Nginx Service
9. Start PHP 8.1 FPM Service
