#!/bin/bash
set -eux

dnf update -y
dnf install -y java-17-amazon-corretto

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
cat >/etc/yum.repos.d/jenkins.repo <<'EOR'
[jenkins]
name=Jenkins-stable
baseurl=https://pkg.jenkins.io/redhat-stable
gpgcheck=1
gpgkey=https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
EOR

dnf install -y jenkins
systemctl enable jenkins
systemctl start jenkins
