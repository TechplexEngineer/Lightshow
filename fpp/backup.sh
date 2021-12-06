#!/bin/bash

set -euo pipefail

JQ_FILTER='del(.network.wifi_network[]) | .network.wifi_network[0]=[""]'

FPP_INSTANCES=(master pixels peacestakes renard01 renard02)

count=0
for instance in "${FPP_INSTANCES[@]}"
do
   ((count=count+1))
   echo ">>> Saving FPP config for $instance [$count of ${#FPP_INSTANCES[@]}]"

   curl  -X POST \
      -H "Content-Type:application/x-www-form-urlencoded" \
      -d "protectSensitive=on" \
      -d "backuparea=all" \
      -d "keepExitingNetwork=on" \
      -d "keepMasterSlave=on" \
      -d "restorearea=on" \
      -d "btnDownloadConfig=Download Configuration" \
    "http://$instance/backup.php" | jq "$JQ_FILTER" > "${instance}_all-backup.json"
done
