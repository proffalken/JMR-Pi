#!/bin/bash
#
# JMR-Pi - Copyright Matthew Macdonald-Wallace 2012

JMRI_VERSION="JMRI.3.0-r20870"
WORKING_DIR=$(pwd)

function warning()
{
  echo "WARNING: $1"
}

function error()
{
  echo "ERROR: $1"
  exit 1
}

# create the downloads dir and get the latest stable version of JMRI
mkdir jmri_downloads
cd jmri_downloads
echo "Fetching JMRI from sourceforge"
wget -O $JMRI_VERSION.tgz "https://sourceforge.net/projects/jmri/files/production%20files/$JMRI_VERSION.tgz/download"
if [ $? -ne 0 ]
then
  error "Failed to download JMRI sources."
fi

echo "Unpacking the source into /opt"
cd /opt
tar -zxf $WORKING_DIR/jmri_downloads/$JMRI_VERSION.tgz
if [ $? -ne 0 ]
then
  error "Failed to unpack JMRI sources into /opt"
fi

# installing the correct java txrx library:
apt-get -y install openjdk-7-jre librxtx-java tightvncserver
if [ $? -ne 0 ]
then
  error "Failed to install dependencies"
fi

cd /opt/JMRI/lib/linux/armv5
mv librxtxSerial.so librxtxSerial.so.jmri
ln -s /usr/lib/jni/librxtxSerial.so

# create the jmri user that we will run as:
useradd -m jmri

# copy the files to the correct location and set permissions:
cp $WORKING_DIR/scripts/init.d/vncserver /etc/init.d/vncserver
chmod +x /etc/init.d/vncserver
mkdir -p /home/jmri/.config/lxsession/LXDE
echo '@/opt/JMRI/PanelPro' >> /home/jmri/.config/lxsession/LXDE/autostart
mkdir /home/jmri/.vnc
cp $WORKING_DIR/scripts/passwd /home/jmri/.vnc/passwd
chown -Rf jmri: /home/jmri
chown -Rf jmri: /opt/JMRI

# start the services:
/etc/init.d/vncserver start
if [ $? -ne 0 ]
then
  warning "VNC server failed to start"
fi

# add the vnc service to start at boot
update-rc.d vncserver defaults

# get the current ip address
if [ -e /sys/class/net/wlan0 ]; then
  export INTERFACE="wlan0"
elif [ -e /sys/class/net/eth0 ]; then
  export INTERFACE="eth0"
fi
IPADDRESS="$(ifconfig $INTERFACE | sed -n '/^[A-Za-z0-9]/ {N;/dr:/{;s/.*dr://;s/ .*//;p;}}')"

# echo the details:
echo -e "Your JMRI server is ready...\n============\n\nPlease connect to $IPADDRESSi:5901 with a VNC client to configure JMRI.\n\nPlease note that JMRI will take several minutes to start the first time it is run."

exit 0

