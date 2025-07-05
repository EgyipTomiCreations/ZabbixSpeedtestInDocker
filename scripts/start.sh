#!/bin/bash
echo "==> Starting ISP speedtest"
# Run the speedtests once at container start
su -s /bin/bash root -c "/etc/zabbix/script/speedtest-isp.sh --run"

echo "==> Starting LAN speedtest"
su -s /bin/bash root -c "/etc/zabbix/script/speedtest-lan.sh -a"

# Start cron in background
echo "==> Starting crontab"
service cron start

# Start the Zabbix agent in foreground
echo "==> Starting Zabbix Agent"
zabbix_agentd -f
