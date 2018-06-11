#!/bin/bash		

if [ ! $(whoami) == "root" ] ;then
  echo "请用root用户执行脚本"
  exit 0;
fi

yum update -y 
yum install -y gcc gcc-c++ openssl-devel curl-devel expat-devel perl-ExtUtils-MakeMaker package ncurses-devel make wget

APP_PATH=/home/vimda/app

mkdir -p ${APP_PATH}

#wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.9.5.tar.gz
tar -zxvf git-2.9.5.tar.gz
cd git-2.9.5

make prefix=/usr/local all
make prefix=/usr/local install 
#rm -rf git-2.9.5*


cd /home/vimda/install_java

# install java
cat jdk-8u171-linux-x64* > jdk-8u171-linux-x64.tar.gz
tar -zxvf jdk-8u171-linux-x64.tar.gz
mv jdk1.8.0_171 ${APP_PATH}/

# install maven 
tar -zxvf apache-maven-3.5.3-bin.tar.gz
mv apache-maven-3.5.3  ${APP_PATH}/

chown -R vimda:vimda /home/vimda

# env
#su vimda
#cd ~
echo "export JAVA_HOME=/home/vimda/app/jdk1.8.0_171" >> /home/vimda/.bashrc
echo "export PATH=\${JAVA_HOME}/bin:\${PATH}" >> /home/vimda/.bashrc

echo "export M2_HOME=/home/vimda/app/apache-maven-3.5.3" >> /home/vimda/.bashrc
echo "export PATH=\${PATH}:\${M2_HOME}/bin" >> /home/vimda/.bashrc
echo "export MAVEN_OPTS='-Xms256m -Xmx512m'" >> /home/vimda/.bashrc

rm -rf /home/vimda/install_java

cp /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime

