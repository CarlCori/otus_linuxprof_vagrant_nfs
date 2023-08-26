echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
echo "nameserver 8.8.4.4" | sudo tee -a /etc/resolv.conf
sudo yum update -y
sudo yum install nfs-utils nano -y
systemctl enable firewalld --now
systemctl status firewalld

firewall-cmd --add-service="nfs3" \
--add-service="rpc-bind" \
--add-service="mountd" \
--permanent
firewall-cmd --reload

systemctl enable nfs --now

mkdir -p /srv/share/upload
chown -R nfsnobody:nfsnobody /srv/share
chmod -R 0777 /srv/

cat << EOF > /etc/exports
/srv/share 192.168.0.151/32(rw,sync,root_squash)
EOF

exportfs -r
