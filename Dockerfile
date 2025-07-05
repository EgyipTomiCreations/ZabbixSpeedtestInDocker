FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Függőségek + Zabbix 7.4 repo
RUN apt update && apt install -y \
    wget curl gnupg lsb-release iputils-ping \
    ca-certificates cron apt-transport-https iperf3 jq bc && \
    curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | bash && \
    apt install -y speedtest && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Zabbix 7.4 repó hozzáadása
RUN wget https://repo.zabbix.com/zabbix/7.4/release/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.4+ubuntu22.04_all.deb && \
    dpkg -i zabbix-release_latest_7.4+ubuntu22.04_all.deb && \
    apt update && \
    apt install -y zabbix-agent

RUN mkdir -p /var/log/zabbix && chown zabbix:zabbix /var/log/zabbix
# Scriptek másolása
COPY scripts/ /etc/zabbix/script/
RUN chmod +x /etc/zabbix/script/*.sh
COPY config/speedtest.conf /etc/zabbix/zabbix_agentd.d/speedtest.conf

# Cron fájl másolása
COPY config/crontab /etc/cron.d/speedtest-cron
RUN chmod 0644 /etc/cron.d/speedtest-cron

#zabbix agentd config
COPY config/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf

# Port Zabbix Agent-hez
EXPOSE 10050

ENTRYPOINT ["/etc/zabbix/script/start.sh"]
