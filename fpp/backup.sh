#!/bin/bash

set -euo pipefail

JQ_FILTER='del(.network.wifi_network[]) | .network.wifi_network[0]=[""]'

curl  -X POST \
   -H "Content-Type:application/x-www-form-urlencoded" \
   -d "protectSensitive=on" \
   -d "backuparea=all" \
   -d "keepExitingNetwork=on" \
   -d "keepMasterSlave=on" \
   -d "restorearea=on" \
   -d "btnDownloadConfig=Download Configuration" \
 'http://matrix/backup.php' | jq "$JQ_FILTER" > "matrix_all-backup.json"

curl  -X POST \
   -H "Content-Type:application/x-www-form-urlencoded" \
   -d "protectSensitive=on" \
   -d "backuparea=all" \
   -d "keepExitingNetwork=on" \
   -d "keepMasterSlave=on" \
   -d "restorearea=on" \
   -d "btnDownloadConfig=Download Configuration" \
 'http://fpp/backup.php' | jq "$JQ_FILTER" > "fpp_all-backup.json"
