echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
echo "nameserver 8.8.4.4" | sudo tee -a /etc/resolv.conf
sudo yum update -y
yum install nfs-utils nano -y

mkdir -p /mnt/share/

systemctl enable firewalld --now
systemctl status firewalld

echo "192.168.0.150:/srv/share /mnt/share nfs vers=3,proto=udp defaults 0 0" >> /etc/fstab

systemctl daemon-reload
systemctl restart remote-fs.target

