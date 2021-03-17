#!/bin/bash

if [[ -z $sleep_time ]];then
   sleep_time=30
else
   echo "sleep_time is $sleep_time seconds"
fi

adapter="$(ip route list | grep default | awk '{print $NF})'"
sys_route="/sys/class/net/$adapter/statistics"
rx_bytes="$(cat $sys_route/rx_bytes)"
rx_errors="$(cat $sys_route/rx_errors)"
tx_bytes="$(cat $sys_route/tx_bytes)"
tx_errors="$(cat $sys_route/tx_errors)"
sleep $sleep_time
rx_bytes1="$(cat $sys_route/rx_bytes)"
rx_errors1="$(cat $sys_route/rx_errors)"
tx_bytes1="$(cat $sys_route/tx_bytes)"
tx_errors1="$(cat $sys_route/tx_errors)"

rx_tot_bytes=$(($rx_bytes1 - $rx_bytes))
tx_tot_bytes=$(($tx_bytes1 - $tx_bytes))
rx_tot_errors=$(($rx_errors1 - $rx_errors))
tx_tot_errors=$(($tx_errors1 - $tx_errors))

test_var=$(echo ''{\"rx\":[{\"bytes\": "$rx_tot_bytes"}, {\"errors\": "$rx_tot_errors"}],\"tx\":[{\"bytes\": "$tx_tot_bytes"}, {\"errors\": "$tx_tot_errors"}]}'')
echo $test_var | jq .
