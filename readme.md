# 🧪 Zabbix LAN + ISP Speed Monitor

Quick and easy LAN + ISP speed monitoring via Zabbix + iperf3 and speedtest in Docker.

## ⚙️ Steps

1. **Edit Zabbix Agent Config**

2. **Edit `speedtest-lan`**
   - Set IP of the remote `iperf3` server

3. **On remote machine**
   - Install `iperf3`
   - Run iperf3 server as a service

4. **Build & Run container**
   ```bash
   docker build -t zabbix-lan-monitor .
   docker run --rm --network host zabbix-lan-monitor