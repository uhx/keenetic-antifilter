#!/bin/sh

if [ "$id-$change-$connected-$link-$up" == "OpenVPN0-link-yes-up-up" ]; then
        echo "OpenVPN is up!!";
        echo "Interface: $system_name";
        echo "Setup routes..."
        /opt/etc/cron.daily/vpn-passfilter.sh &
fi