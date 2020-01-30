#!/bin/bash
  
standby_primary=`sudo -u postgres repmgr cluster show 2>/dev/null | awk -F '|' '$3 ~ "standby" && $4 ~ ".* as primary" {print $2}' | tr -d "\"" | wc -l`
primary_primary=`sudo -u postgres repmgr cluster show 2>/dev/null | awk -F '|' -v host="192.168.60.3" '$2 ~ host && $3 ~ "primary" && $4 ~ "\* running" {print $2}' | tr -d "\"" | tr -d " "`
if [[ "$standby_primary" == "0"  && "$primary_primary" == "192.168.60.3" ]];then
echo 0
exit 0

else

echo 2
exit 2


fi

