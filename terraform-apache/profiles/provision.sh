profiles/provision.sh 
#!/bin/bash

# Local Time:
sudo rm -fv /etc/localtime
sudo ln -s /usr/share/zoneinfo/America/Argentina/Buenos_Aires /etc/localtime
sudo useradd -s /bin/false node_exporter
sudo wget https://devops-tools-public.s3.amazonaws.com/node_exporter-1.0.1/node_exporter -O /usr/local/bin/node_exporter
sudo chmod 755 /usr/local/bin/node_exporter
sudo chown node_exporter.node_exporter /usr/local/bin/node_exporter
sudo wget https://devops-tools-public.s3.amazonaws.com/node_exporter-1.0.1/node_exporter.service -O /etc/systemd/system/node_exporter.service
sudo chmod 644 /etc/systemd/system/node_exporter.service
sudo chown root.root /etc/systemd/system/node_exporter.service
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

sudo apt update -y
sudo apt install -y httpd net-tools vim
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>Hola desde Apache en EC2!</h1>" > /var/www/html/index.html

