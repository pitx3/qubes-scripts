# qubes-scripts
Collection of helpful scripts for use with the Qubes operating system. These scripts are designed specifically for Qubes. Use on other systems has strongly discouraged.

## USE AT YOUR OWN RISK
Absolutely no warranty is given. You're on your own if something breaks or you lose data. Be sure to understand what each script is doing *before* you install it. Use a test qube if you're not sure. Backup your data. Follow all the other standard "do your best to not kill your system" advice that's given everywhere. If you're using Qubes then it's assumed you have at least some level of technical skill but that doesn't mean something bad can't happen.

If you're not using Qubes then it is strongly recommend you *do not use these scripts*. You could cause permanent damage to your system or cause major data loss. Nobody wants that. 

## Scripts 
Full documentation for each script can be found in the 'docs' folder. Only a summary is provided here. Please read the full doc for each script as there is typically more to it than just copying the script and running it. If you ask a question, the first thing I'll ask back is "did you read the full doc?" Be smart. Read the full doc first before asking questions.

All command line arguments are Debian specific. You can probably change 'apt' to 'dnf' for Fedora-based installations, but no guarantees. I'm most familiar with Debian so that's what I went with here.

### Automatic Clipboard Clearing (cbclear.sh)
This script will automatically clear the clipboard after a specified amount of time from whenever the clipboard changes. The default is 20 seconds. The script is easily changed to whatever amount of time you want.

Why? When copying values from KeepassXC to a different qube these values are not automatically cleared on the destination qube which opens a minor security hole. This script attempts to mitigate that hole.

### Automatic Printing (autoprint.sh)
This script works in conjunction with a specialized printer qube. It's set up so when you copy a PDF or TXT file to the printer qube the document will automatically print. 

This could potentially be a security risk depending on your environment. Please understand what's going on before using it.

Huge thank you to 'whoami' for the excellent detailed instructions on setting up the printer qube itself. (link: https://forum.qubes-os.org/t/setup-a-wlan-lan-printer-ipp-everywhere/28741)

