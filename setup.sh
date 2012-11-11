#!/bin/bash
#
# JMR-Pi - Copyright Matthew Macdonald-Wallace 2012

JMRI_VERSION="JMRI.3.0-r20870"
WORKING_DIR=$(pwd)

# create the downloads dir and get the latest stable version of JMRI
mkdir jmri_downloads
cd jmri_downloads
echo "Fetching JMRI from sourceforge"
wget -O $JMRI_VERSION.tgz "https://sourceforge.net/projects/jmri/files/production%20files/$JMRI_VERSION.tgz/download"
echo "Unpacking the source into /opt"
cd /opt
tar -zxf $WORKING_DIR/jmri_downloads/$JMRI_VERSION.tgz
# installing the correct java txrx library:
apt-get -y install openjdk-7-jre librxtx-java
cd /opt/JMRI/lib/linux/armv5
mv librxtxSerial.so librxtxSerial.so.jmri
ln -s /usr/lib/jni/librxtxSerial.so
