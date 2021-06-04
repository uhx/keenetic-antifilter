#!/bin/sh

# default, but probably you must change it
OPENVPN_IFACE=ovpn_br0
#

CRON="/opt/etc/cron.daily/vpn-passfilter.sh"
IFSTATE="/opt/etc/ndm/ifstatechanged.d/vpn-passfilter.sh"

cp install/setup_routes.sh $CRON
cp install/ifstate.sh $IFSTATE

chmod +x $CRON
chmod +x $IFSTATE

sed -i 's/ovpn_br0/$OPENVPN_IFACE/' $CRON