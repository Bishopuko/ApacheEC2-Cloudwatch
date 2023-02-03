#!/bin/bash


sudo yum update -y

sudo yum install -y httpd

sudo yum install -y awslogs
sudo systemctl start awslogsd
sudo systemctl enable awslogsd.service
sudo systemctl start httpd

sudo usermod -a -G apache ec2-user


