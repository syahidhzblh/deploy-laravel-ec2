# Guide to Deploy Laravel Starter on AWS EC2

In this section i will show how to deploy Laravel Starter on AWS EC2

# Laravel Starter (based on Laravel 10.x) from Nasir Khan Saikat

For this project i used Sample App Laravel Starter from Nasir Khan Saikat to Deploy on AWS EC2
you can find this project on https://github.com/nasirkhan/laravel-starter.git

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

## Verify Package

1. Connect to instance using SSH

```bash
ssh -i (YOUR_KEY_PAIR) ubuntu@PUBLIC_IP_AWS_EC2
```

2. If you rejected to connect instance using SSH, try to `sudo chmod 400 (YOUR_KEY_PAIR)`. And then reconnect
3. After you successfully connect instance using SSH, made sure all package successfully installed.
4. For verify package you can use `(PACKAGE_NAME --version)` example `nginx --version`
5. Check Nginx already running using `sudo systemctl status nginx`
6. Try to Access Website via Public IP Instance AWS EC2.
7. If success, it will return like this.
<p align=center><img src="https://github.com/syahidhzblh/deploy-laravel-ec2/blob/4ffa898da99d2b5311b790d8692afff8da8a8a67/assets/img/nginx-test.png" alt="Nginx Test"></p>

## Installation Laravel

1. Go to `/var/www/html`
2. Remove default index `sudo rm index.nginx-debian.html`
3. Git clone Laravel Starter using `git clone https://github.com/nasirkhan/laravel-starter.git`
4. After done, open laravel-starter folder
5. Install Composer package

```bash
sudo curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
```

5. Run `sudo composer install`
6. Duplicate `.env.example` to `.env` using

```bash
sudo cp .env.exampe .env
```

7. Set permission setting for mysql & Root Password using `mysql_secure_installation`
8. Login mysql using `mysql -u root -p`
9. Enter root password
10. Run this MYSQL Script

```sql
CREATE DATABASE laravel_starter;
CREATE USER 'laravel_user'@'localhost' IDENTIFIED BY 'Laravel123!!!';
GRANT ALL PRIVILEGES ON laravel_starter.* TO 'laravel_user'@'localhost' IDENTIFIED BY 'Laravel123!!!';
FLUSH PRIVILEGES;
```
11. Test login mysql using laravel user `sudo msyql -u laravel_user -p` 
12. Try to use DB laravel_starter and show tables

```sql
USE DATABASE laravel_starter;
SHOW TABLES;
``` 
13. Change .env config for DB Connection 
14. Run `sudo nano .env` 
15. Edit following this

```
APP_URL=YOUR_IP_PUBLIC_AWS
DB_USER=laravel_user
DB_PASSWORD=Laravel123!!!
```
16. Run `sudo php artisan migrate --seed` 
17. Run `sudo php artisan key:generate` 
18. Set Required File Permission
```bash
sudo chown -R www-data:www-data /var/www/html/laravel-starter/
sudo chmod -R 755 /var/www/html/laravel-starter
```
19. Change Path Folder to `/etc/nginx/sites-available` 
20. Create new file config nginx `sudo nano laravel-server` 
21. Copy configuration on file sites-enabled-laravel on this repo and then paste it 
22. Save and Exit 
23. Create link to sites-enabled using `sudo ln /etc/nginx/sites-available/laravel-server /etc/nginx/sites-enabled` 
24. Check configuration file nginx `nginx -t` 
25. Unlink default nginx configuration `unlink default` 
26. Reload nginx `sudo systemctl reload nginx` 
27. After successfully, let's try open Laravel Starter via Public IP was already set (via HTTP Protocol)

<p align=center><img src=https://github.com/syahidhzblh/deploy-laravel-ec2/blob/dc502b57a94c90d8d44fedd2b8f1f7cd668d5725/assets/img/test-laravel-starter-using-ip.png alt="Open Laravel Starter using IP via http"></p>

## Setting up SSL using Lets Encrypt on Nginx
