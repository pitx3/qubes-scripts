## clipboard clearing (cbclear.sh)
This script will automatically clear the clipboard after a specified amount of time from whenever the clipboard changes. The default is 20 seconds. The script is easily changed to whatever amount of time you want.

Why? When copying values from KeepassXC to a different qube these values are not automatically cleared on the destination qube which opens a minor security hole. This script attempts to mitigate that hole.

### Dependencies
This script depends on xsel for the clipboard functionality. To properly install it, open a terminal in the _template_ for the qube you want to install this script. Then use the following command:
```
sudo apt install xsel
```
Once installed, shut down the template and restart the app qube before beginning installation.

### Installation
There are two steps to install the clipboard clearing script so that it automatically runs. All installation takes place on the specific app qube you want to have the clipboard automatically cleared for.

*Do not install this on the template.* You won't get the desired results.

First, add the cbclear.sh file to /home/user.\
Be sure it has execute permissions.
```
chmod +x /home/user/cbclear.sh
```
Second, edit the /rw/config/rc.local file to include the following:
```
nohup runuser -l user -c /home/user/cbclear.sh >/home/user/cbclear.log 2>&1 &
```
This tells the system to run the script at startup running as the local user rather than root. It also logs all output to the cbclear.log file for help when troubleshooting. Feel free to change this to /dev/null once you have everything up and running.

From here you can either restart the qube or manually run the rc.local script to kick off the cbclear script in the background
```
sudo /rw/config/rc.local
```

### Testing
The easiest way I found to test is to launch a text editor (e.g. Mousepad) type some text, copy it, then paste repeatedly. After 20 seconds (or whatever you might have changed the duration to) you should no longer be able to paste. Repeat as desired. 

If it's not behaving as expected, follow the troubleshooting steps below. And you can always manually run the script from a terminal
```
cd ~
./cbclear.sh
```
If you run it like this, the script output will show in the terminal. No need to view log files separately. Use Ctrl+C to stop the script.

### Troubleshooting
Sometimes things go wrong despite our best intentions. Here are some things you can try should this script not behave as expected.

#### Check the logs
Viewing the logs while copying to the clipboard is the best place to start while testing and/or troubleshooting. It's best to use the tail command (aka tailing the log) rather than opening the logfile in a text editor.
```
tail -f /home/user/cbclear.log
```
You should see output similar to the following if things are running properly. Every time you copy to the clipboard you should see a "clipboard contents changed" message followed by a Contents Hash value followed by a countdown until the clipboard is cleared.
```
2026-01-26 15:37:48 : clipboard contents changed
Contents Hash: 5621a6926b74ba1f3a3c17cb53d4ba79db4196e8386888958a4b0f91cc291df4  -
2026-01-26 15:37:49 : clearing clipboard in 20 seconds
2026-01-26 15:37:54 : clearing clipboard in 15 seconds
2026-01-26 15:37:59 : clearing clipboard in 10 seconds
2026-01-26 15:38:04 : clearing clipboard in 5 seconds
2026-01-26 15:38:08 : clipboard cleared
2026-01-26 15:38:21 : clipboard contents changed
Contents Hash: 2363c51bfd96109300e29b32a900c2b45c3bb8190098e9e8323fec29fa003957  -
2026-01-26 15:38:23 : clearing clipboard in 20 seconds
2026-01-26 15:38:28 : clearing clipboard in 15 seconds
2026-01-26 15:38:33 : clearing clipboard in 10 seconds
2026-01-26 15:38:38 : clearing clipboard in 5 seconds
2026-01-26 15:38:42 : clipboard cleared
```
Naturally you can verify that the clipboard actually cleared by attempting to paste once the "clipboard cleared" message is shown.

If the logs do not appear as above, try the following:

#### Check if the script is running
```
ps x | grep cbclear.sh
```
Expected output (job numbers will be different of course)
```
552118 ?        Ss     0:00 /bin/bash /home/user/cbclear.sh
553139 pts/0    S+     0:00 grep cbclear.sh
```
#### Kill the process
To kill the running process, note the job number from above that is *not* the grep command, then run the kill command
```
kill 552118
```
Run the check above to be sure the script is no longer running
#### Manually restarting the rc.local script
While the rc.local script is executable, it's designed to be run as root.
```
sudo /rw/config/rc.local
```
