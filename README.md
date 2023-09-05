# Guide to Deploy Laravel Starter on AWS EC2

In this section i will show how to deploy Laravel Starter on AWS EC2

# Laravel Starter (based on Laravel 10.x) from Nasir Khan Saikat

For this project i used Sample App Laravel Starter from Nasir Khan Saikat for Deploy to AWS EC2
you can find this project on `https://github.com/nasirkhan/laravel-starter.git`

# Deployment Step

## Create Instance on AWS EC2

1. Go to your AWS Console, then open the EC2 Instance.
2. Create new Instance, you can find on Launch Instance Button.
3. On this section i use Free Tier Spec:

- Operating System : Ubuntu 22.04 LTS
- Instance Type : t2.micro
- Storage : 8 GB
- Port Allow Needed : 22 (SSH), 80(HTTP), 433(HTTPS)

4. To shorten the time, on this section i use metadata was i created on this Repository.
5. Click Advanced Details, go to Metadata Section and drop it metadata-laravel config into it.
6. Review Instance on Summary, made sure all the spec and config already correct. Choose Launch Instance.
