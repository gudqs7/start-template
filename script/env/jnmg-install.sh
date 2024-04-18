#!/bin/bash

release="centos"

if [ -f /etc/redhat-release ]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
else
    release=""
fi


if [[ x"${release}" == x"centos" ]]; then
    sudo yum update -y
    echo '-----------------Update Finished. Start Install-----------------'
    sudo yum install -y java-1.8.0-openjdk.x86_64 nginx maven git
    sudo systemctl enable nginx
    sudo systemctl restart nginx
elif [[ x"${release}" == x"debian" || x"${release}" == x"ubuntu" ]]; then
    sudo apt-get update
    echo '-----------------Update Finished. Start Install-----------------'
    sudo apt-get install -y openjdk-8-jdk nginx maven git
    sudo systemctl enable nginx
    sudo systemctl restart nginx
else
    v=`cat /proc/version`
    echo "Unknown Linux Release: ${v}"
fi
