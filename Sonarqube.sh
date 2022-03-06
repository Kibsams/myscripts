#!/bin/bash

    #Author: Samuel
    #Date: 3-2-2022
    #Description: Script to install Sonarqube on system


echo "We need to install Java...Installing now"
echo
sleep 1
sudo yum install java-11-openjdk-devel -y
sleep 1
echo
echo "Let's check if you have wget on your system. We appreciate your patience."
sleep 1
echo
sudo yum list installed wget
if [ $? = 0 ]

then
echo "Great, looks like you have wget. Let's now install the Sonarqube files"
echo
sleep 1
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.3.0.51899.zip
sleep 1
echo

else
echo "Looks like you need to install wget. Installing now"
sleep 1
echo
sudo yum install wget -y
echo
sleep 1
echo "Now, lets install the Sonarqube files"
echo 
sleep 1
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.3.0.51899.zip

fi
echo 
echo "Let's check if you have unzip installed."
echo 
sleep 1
sudo yum list installed unzip
if [ $? = 0 ]

then 
echo "Great, you have unzip on your system. Lets use it to unzip the Sonarqube files"
echo 
sleep 1
sudo unzip sonarqube-9.3.0.51899.zip
echo 
sleep 1

else
echo "Looks like you don't have unzip. Let's install it. Please wait..."
echo 
sleep 1
sudo yum install unzip -y
echo 
sleep 1
echo "Now lets unzip the Sonarqube files"
echo 
sleep 1
sudo unzip sonarqube-9.3.0.51899.zip
echo 
sleep 1

fi

echo -e "\nObtaining $USER access, one second...\n"
sleep 1
echo
sudo chown -R $USER:$USER /home/$USER/sonarqube-9.3.0.51899
echo
sleep 1
echo "Starting service in afew..."
echo
sleep 1
cd /home/$USER/sonarqube-9.3.0.51899/bin/linux-x86-64
echo
./sonar.sh start
sleep 1
echo
echo "Opening port 9000, tick tock, tick tock..."
echo
sleep 1
sudo firewall-cmd --permanent --add-port=9000/tcp
sudo firewall-cmd --reload
if [ $? = 252 ]

then 
echo -e "\nNothing ever works, does it? Let's start your firewall service\n"
sleep 1
echo
sudo systemctl start firewalld
echo
sudo firewall-cmd --reload
sleep 1
fi
echo "Use this link to connect to the Sonarqube server"
sleep 1
echo
echo -e "\n http://`hostname -I | awk '{print$2}'`:9000\n"
sleep 1
echo "Grateful for your patience, till next time!"
#THE END (VOILA)