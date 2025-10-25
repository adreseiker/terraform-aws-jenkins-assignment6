#!/bin/bash
set -eux
ENV_NAME="$1"

dnf update -y
dnf install -y httpd

systemctl enable --now httpd

echo "<h1>Hello from ${ENV_NAME}</h1>" > /var/www/html/index.html
