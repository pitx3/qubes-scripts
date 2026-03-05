#!/bin/bash

WATCH_DIR="/home/user/QubesIncoming"

# Change the --include extensions to what you want. 
# Note that lp is limited in what it can print.
# It may not work well with .odt or .docx files.

inotifywait -m -r \
  -e create,isdir \
  --include '.*\.(pdf|txt)$' \
  --format "%w%f" \
  "$WATCH_DIR" | while read -r event; do
    echo "--- New incoming file: $event"

    # print the file
    lp -d "Printer-Q" "$event"

    # not sure if sleep is strictly necessary but felt it was safer than immediately deleting the file
    sleep 5

    # delete the file
    rm -f "$event"
    echo "Deleted file $event"
done
