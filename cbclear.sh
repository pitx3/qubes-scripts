#!/bin/bash

# Clears clipboard after a set time (in seconds)
# Triggers if contents of the clipboard have changed but then
#   do not change for a certain amount of time

# Requires xsel to be installed. Do this in the qube template.
# sudo apt install xsel

# Place this file in /home/user. Make sure it has execute permissions.

# To have this automatically run at boot, add the following to /rw/config/rc.local
# Do this in the specific qube you want it to run. Do not do this in the template.
# nohup runuser -l user -c /home/user/cbclear.sh >/home/user/cbclear.log 2>&1 &

echo "Running..."

OLDCONTENTS=""
CONTENTS=""

# Number of seconds before clearing the clipboard
cleartime=20

# Delay in seconds between "clearing clipboard" countdown messages
# Make sure this is a positive number. Do not put zero here. The script will break!
displayinterval=5

# Initialize our countdown counter
counter=$cleartime

# -------------------------
# Loop forever
# -------------------------
while [ true ];
do

  # Delay so we don't burn a bajillion CPU cycles
  # This also means we can count down by one second at a time.
  sleep 1

  # Formatted date for logging
  dt=$(date +"%Y-%m-%d %T")

  OLDCONTENTS=$CONTENTS

  # Get the current clipboard contents
  CONTENTS="$(xsel -ob)"

  # Is there something in the clipboard?
  if [[ $CONTENTS != "" ]]; then
    # Is the clipboard the same as it was before?
    if [[ $OLDCONTENTS == $CONTENTS ]]; then
      # Are we done counting down?
      if [[ $counter -le 1 ]]; then
        # Clear the clipboard
        xsel --clipboard --clear
        echo "$dt : clipboard cleared"
        counter=$cleartime
      else
        # Check if we display a message
        if [[ $(( counter % displayinterval )) == 0 ]]; then
          echo "$dt : clearing clipboard in $counter seconds"
        fi
        counter=$(( counter - 1 ))
      fi
    else
      # Clipboard contents changed. Restart the countdown.
      echo "$dt : clipboard contents changed"
      counter=$cleartime
    fi
  fi

done
