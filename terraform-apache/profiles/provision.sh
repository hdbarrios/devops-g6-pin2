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
sudo apt install -y apache2 net-tools vim
sudo systemctl start apache2
sudo systemctl enable apache2

echo -e '<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Integrantes</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 20px;
        }
        table {
            width: 50%;
            margin: 0 auto;
            border-collapse: collapse;
            text-align: left;
        }
        th, td {
            border: 1px solid #000;
            padding: 10px;
        }
        th {
            background-color: #f2f2f2;
        }
        img {
            margin-top: 20px;
            max-width: 300px;
            height: auto;
        }
    </style>
</head>
<body>
    <h1>edu.mundose.com - PIN2</h1>
    <table>
        <tr>
            <th>Integrantes</th>
            <th>Email</th>
        </tr>
        <tr>
            <td>Juan Pablo Heyda</td>
            <td>juanpabloh.123@gmail.com</td>
        </tr>
        <tr>
            <td>Renzo Emiliano Carletti</td>
            <td>renzocarletti@hotmail.com / pipito1498@gmail.com</td>
        </tr>
        <tr>
            <td>Johanna Dominguez</td>
            <td>johisd9@hotmail.com</td>
        </tr>
        <tr>
            <td>Lucas Bufano</td>
            <td>lucas.bufano2@gmail.com</td>
        </tr>
        <tr>
            <td>Hector Barrios</td>
            <td>hdbarrios@gmail.com</td>
        </tr>
    </table>
    <img src="https://tf-state-apache-bucket-img.s3.us-east-1.amazonaws.com/img/grupo6.png" alt="Grupo6">
</body>
</html>' > /var/www/html/index.html
