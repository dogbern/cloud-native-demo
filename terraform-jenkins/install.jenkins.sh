#!/bin/bash
sudo yum update -y

echo "Install Java JDK 8"
sudo yum remove java -y
sudo yum install java-1.8.0-openjdk -y

echo "Install Maven"
sudo yum install maven -y 

echo "Install git"
sudo yum install git -y

echo "Install Docker engine"
sudo yum update -y
sudo yum install docker -y
sudo chkconfig docker on

echo "Install Jenkins"
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum install -y jenkins
sudo usermod -a -G docker jenkins
sudo systemctl daemon-reload
sudo chkconfig jenkins on
sudo service docker start
sudo service jenkins start