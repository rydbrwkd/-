#!/bin/sh
######################
#  centos7.5 1804    #
#  by dsdata.Co.Ltd  #
#  2018-11-03        #
#  Author JJ         #
######################
. /etc/profile
mkdir /home/work
echo "work directory is ready!"
sleep 2
######################
#  sysinfo writed    #
######################
cd /home/work
echo "now" `pwd`
sleep 2
/sbin/hwclock --systohc
/sbin/hwclock -r >> work_history.txt
uname -a >> work_history.txt
grep . /etc/*-release >> work_history.txt
ifconfig >> work_history.txt
df -Th >> work_history.txt
free -m >> work_history.txt
cat /proc/cpuinfo >> work_history.txt
dmidecode -t 17 >> work_history.txt
echo "sysinfo writed"
sleep 2
######################
#  selinux disabled  #
######################
#sed -i "7s/#SELINUX/SELINUX/" /etc/selinux/config
#sed -i "7s/enforcing/disabled/" /etc/selinux/config
cd /etc/selinux
echo "now" `pwd`
sleep 2
cp -p config config.bak
sed -i '/SELINUX=enforcing/ c\SELINUX=disabled' /etc/selinux/config
cd /home/work
echo "now" `pwd`
cat /etc/selinux/config >> work_history.txt
echo "selinux disabled"
sleep 2
######################
#  PermitRootLogin   #
######################
cd /etc/ssh
echo "now" `pwd`
sleep 2
cp -p sshd_config sshd_config.bak
sed -i '/#PermitRootLogin yes/ c\PermitRootLogin yes' /etc/ssh/sshd_config
cd /home/work
cat /etc/ssh/sshd_config >> work_history.txt
echo "ssh root login permitted"
sleep 2
######################
#  firewalld disable #
######################
cd /home/work
echo "now" `pwd`
sleep 2
systemctl stop firewalld >> work_history.txt
systemctl disable firewalld >> work_history.txt
echo "firewalld disabeld"
sleep 2
######################
#  update yum.conf   #
######################
cd /etc
echo "now" `pwd`
sleep 2
sed -i '2 i\exclude=kernel*' yum.conf
echo "insert exlude=kernel* to yum.conf 2line"
sleep 2
######################
#  yum install       #
######################
cd /home/work
echo "now" `pwd`
sleep 2
yum install -y cmake *gcc* cvs telnet ypbind compat*
sleep 1
yum install -y glibc.i686 glibc*
sleep 1
yum install -y redhat-lsb-core libcurl* libxslt*
sleep 1
yum install -y pcre*
sleep 1
yum install -y libz* bzip2-devel* readline-devel*
echo "default rpm installed"
sleep 2
######################
#  yum update        #
######################
cd /home/work
echo "now" `pwd`
sleep 2
yum -y update
echo "yum updated"
sleep 2
###########################################
#  link libpcre.so.1.2.0 to libpcre.so.0  #
###########################################
cd /usr/lib64
echo "now" `pwd`
sleep 2
ln -sf libpcre.so.1.2.0 libpcre.so.0
echo "libpcre linked"
cd /home/work
sleep 2
###########################################
#  link libcurl.so.4.1.1 to /usr/lib64    #
###########################################
cd /home/work
echo "now" `pwd`
sleep 2
chmod 755 libcurl.so.4.1.1
mv libcurl.so.4.1.1 /usr/lib64
echo "libcurl.so.4.1.1 moved"
sleep 2
cd /usr/lib64
echo "now" `pwd`
sleep 2
ln -sf libcurl.so.4.1.1 libcurl.so.3
echo "libpcre linked"
cd /home/work 
sleep 2
