# qubes-scripts
Collection of helpful scripts for use with the Qubes operating system. 
These scripts are designed specifically for Qubes. And although they may work in other situations,
there is no guarantee of this. 

**Use these at your own risk**

## clipboard clearing (cbclear.sh)
This script will automatically clear the clipboard after a specified amount of time
from whenever the clipboard changes. The default is 20 seconds. The script is easily changed
to whatever amount of time you want.

### Dependencies
This script depends on xsel for the clipboard functionality.
To properly install it, open a terminal in the _template_ for the qube you want to 
install this script. Then use the following command:

>sudo apt install xsel

Once installed, shut down the template and restart the qube before beginning installation.

### Installation
There are two steps to install the clipboard clearing script so that it automatically runs.
All installation takes place on the specific qube you want to automatically clear the clipboard.
Do *not* do this on the template. You won't get the desired results.

First, add the cbclear.sh file to /home/user. Be sure it has execute permissions.

Second, edit the /rw/config/rc.local file to include the following:
> nohup runuser -l user -c /home/user/cbclear.sh >/home/user/cbclear.log 2>&1 &

This tells the system to run the script at startup running as the local user rather than root.
It also logs all output to the cbclear.log file for help when troubleshooting. Feel free
to change this to /dev/null once you have everything up and running.


