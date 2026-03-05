## Automatic Printing (autoprint.sh)
This script works in conjunction with a specialized printer qube. It's set up so when you copy a PDF or TXT file to the printer qube the document will automatically print. 

This could potentially be a security risk depending on your environment. Please understand what's going on before using it.

Huge thank you to 'whoami' for the excellent detailed instructions on setting up the printer qube itself. (link: https://forum.qubes-os.org/t/setup-a-wlan-lan-printer-ipp-everywhere/28741)

### Dependencies
First and foremost: **this script has only been tested and confirmed to work using the printer qube setup designed and posted by 'whoami' as noted above.** If you're using any other printer qube setup then there is zero guarantee that this script will work as expected.

This script depends on inotify-tools and specifically the inotifywait function to watch for incoming files.

To install inotify-tools, open a terminal in the _printer template qube_ then use the following command:
```
sudo apt install inotify-tools
```
Once installed, shut down the template and restart the printer app qube before beginning installation.

### Installation
There are two steps to install the automatic printing script so that it automatically runs. All installation takes place on the printer app qube.

*Do not install this on the printer template qube.* You won't get the desired results.

First, add the autoprint.sh file to /home/user.\
Be sure it has execute permissions.
```
chmod +x /home/user/autoprint.sh
```
Second, edit the /rw/config/rc.local file to include the following:
```
/home/user/autoprint.sh >/home/user/autoprint.log 2>&1 &
```
This tells the system to run the script at startup. It will run as root, but that's fine. It also logs all output to the autoprint.log file for help when troubleshooting. Feel free to change this to /dev/null once you have everything up and running.

From here you can either restart the qube or manually run the rc.local script to kick off the autoprint script in the background
```
sudo /rw/config/rc.local
```

### Testing
The quickest test is to just copy something to the printer qube. It should print automatically. Repeat as desired. 

If it's not behaving as expected, follow the troubleshooting steps below. 

### Troubleshooting
Sometimes things go wrong despite our best intentions. Here are some things you can try should this script not behave as expected.

#### Check the logs
Viewing the logs while copying to the clipboard is the best place to start while testing and/or troubleshooting. It's best to use the tail command (aka tailing the log) rather than opening the logfile in a text editor.
```
tail -f /home/user/autoprint.log
```
You should see output similar to the following if things are running properly. 
```
Setting up watches.  Beware: since -r was given, this may take a while!
Watches established.
--- New incoming file: /home/user/QubesIncoming/personal/testfile1.txt
request id is Printer-Q-1 (1 file(s))
Deleted file /home/user/QubesIncoming/personal/testfile1.txt
--- New incoming file: /home/user/QubesIncoming/work/document1.pdf
request id is Printer-Q-2 (1 file(s))
Deleted file /home/user/QubesIncoming/work/document1.pdf
--- New incoming file: /home/user/QubesIncoming/work/document2.pdf
request id is Printer-Q-3 (1 file(s))
Deleted file /home/user/QubesIncoming/work/document2.pdf
```

If the logs do not appear as above, try the following:

#### Check if the script is running
```
ps x | grep autoprint.sh
```
Expected output (job numbers will be different of course)
```
552118 ?        Ss     0:00 /bin/bash /home/user/autoprint.sh
553139 pts/0    S+     0:00 grep autoprint.sh
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

#### Check any script changes
If you changed the file extensions in the script to include things beyond PDF or TXT, check if those types of files will print directly from the printer qube. 

#### Verify you created the printer qube correctly
If you followed the instructions from 'whoami' to create your qube then go back to those and verify that you can print directly from your printer app qube. If you can't, then go back to the article and try again. 

If you followed someone else's instructions for creating a printer qube then this script may not work for you at all.
