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


