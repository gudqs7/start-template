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
    mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
    curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

    sudo yum update -y
    echo '-----------------Update Finished. Start Install-----------------'

    yum install -y perl wget epel-release
    curl -LO http://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
    sudo yum localinstall -y mysql57-community-release-el7-11.noarch.rpm
    rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
    sudo yum install -y mysql-community-server
    sudo systemctl enable mysqld
    sudo systemctl restart mysqld
    sudo systemctl status mysqld
    echo '-----------------Install Mysql Finished. Start Install Redis-----------------'

    sudo yum install -y redis
    sudo systemctl enable redis
    sudo systemctl restart redis
    sudo systemctl status redis
    echo '-----------------Please config redis by--> vi /etc/redis.conf ----------------'

    echo '-----------------Please ChangePassword-----------------'
    grep 'temporary password' /var/log/mysqld.log
    echo 'echo "alter user \"root\"@\"localhost\" identified by \"guddqsZ.0\"; GRANT ALL PRIVILEGES ON *.* TO \"root\"@\"%\" IDENTIFIED BY \"guddqsZ.0\" WITH GRANT OPTION;" | mysql --connect-expired-password -uroot -p'
elif [[ x"${release}" == x"debian" || x"${release}" == x"ubuntu" ]]; then
    sudo apt-get update -y
    echo '-----------------Update Finished. Start Install-----------------'

    sudo apt-get install -y mysql-server
    sudo systemctl enable mysqld
    sudo systemctl restart mysqld
    sudo systemctl status mysqld
    echo '-----------------Install Mysql Finished. Start Install Redis-----------------'

    sudo apt-get install -y redis-server
    sudo systemctl enable redis
    sudo systemctl restart redis
    sudo systemctl status redis
    echo '-----------------Please config redis by--> vi /etc/redis/redis.conf ----------------'

    echo '-----------------Please ChangePassword-----------------'
    echo 'echo "alter user \"root\"@\"localhost\" identified by \"guddqsZ.0\"; GRANT ALL PRIVILEGES ON *.* TO \"root\"@\"%\" IDENTIFIED BY \"guddqsZ.0\" WITH GRANT OPTION;" | mysql -uroot -p'
else
    v=`cat /proc/version`
    echo "Unknown Linux Release: ${v}"
fi
