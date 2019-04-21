#!/bin/bash

echo "**** PACKER_BUILDER_TYPE is ${PACKER_BUILDER_TYPE} ****"
echo "               **** OS is ${OS} ****"
echo "               **** OS_VERSION is ${OS_VER} ****"

mkdir -p /run/sshd

case ${OS} in
  debian,ubuntu)
    apt-get update && apt-get install -y udev locales git procps
    locale-gen en_US.UTF-8
    update-locale LANG=en_US.UTF-8
    ;;
  centos,fedora)
    yum -y update && yum -y install udev git
    ;;
  opensuse)
    zypper refresh && zypper install -y udev git glibc-locale
    systemctl enable sshd
    ;;
esac