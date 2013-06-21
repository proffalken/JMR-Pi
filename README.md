JMR-Pi
======

This repo contains scripts to configure JMRI on a Raspberry PI for use in the computer control of layouts.

To get the code, log onto your R-PI, start a terminal if you do not have one already and run the following commands:

```bash
sudo apt-get install git
git clone https://github.com/proffalken/JMR-Pi
cd JMR-Pi
sudo ./setup.sh
```

This will:

  * Install Git
  * Checkout this repository
  * Change to the checked-out code
  * Run the installation script
  * Create a dedicated JMRI user
  * Start a remote desktop server
  * Launch JMRI

The password for the JMRI user (should you need to connect to the R-Pi and run commands on its behalf!) is "trains".

The message that is generated at the end of the script gives you an IP Address and a Port Number to use to log in via VNC and start a remote desktop session.  Once you have done this, you should see JMRI starting up.
