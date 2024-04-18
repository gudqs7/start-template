ln -s /root/app/app-server.jar /etc/init.d/app
systemctl enable app
systemctl status app
systemctl restart app