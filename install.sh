#!/bin/bash

## instala extras da amazon ec2
sudo amazon-linux-extras install -y epel

## instala PostgreSQL
sudo tee /etc/yum.repos.d/pgdg.repo<<EOF
[pgdg13]
name=PostgreSQL 13 for RHEL/CentOS 7 - x86_64
baseurl=https://download.postgresql.org/pub/repos/yum/13/redhat/rhel-7-x86_64
enabled=1
gpgcheck=0
EOF

sudo yum install -y postgresql13 postgresql13-server
sudo /usr/pgsql-13/bin/postgresql-13-setup initdb
sudo systemctl enable --now postgresql-13

## instala node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install 14

## coloca permissoes corretas em home
chmod og+rX /home /home/user

## cria a tabela base no banco
cp ~/puc-api/database/base-table.sql ~
sudo chown postgres ~/base-table.sql
sudo -u postgres psql -f ~/base-table.sql

## coloca password padrao no banco
sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'postgres';"

## instala dependencias do projeto
cd ~/puc-api
npm install

## configura node como serviço
