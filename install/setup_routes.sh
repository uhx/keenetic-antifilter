#!/bin/sh

dir=/tmp/lst
mkdir -p $dir
file_routes=$dir/antifilter_allyouneed.lst
VPN_IF=ovpn_br0

echo "Downloading list of blocked addresses..."
curl https://antifilter.download/list/allyouneed.lst --output $file_routes 2>/dev/null

VPN_IP=$( ip addr show $VPN_IF | awk '$1 == "inet" {gsub(/\/.*$/, "", $2); print $2}' )

# TODO: maybe fill update in another table and then flush the old one?
ip route flush table 1000

added=0

while read line || [ -n "$line" ]; do
        [ -z "$line" ] && continue

        addr=$(echo $line | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}/[0-9]{1,2}')

        [ -z "$addr" ] && continue

        ip route add table 1000 $addr via $VPN_IP dev $VPN_IF

        added=$(( added + 1 ))
done < $file_routes

ip rule add from all table 1000 priority 1337

echo "Added $added routes"

rm $file_routes