echo "install node_exporter"
curl -o /root/node_exporter_installer.sh https://raw.githubusercontent.com/SukhovDaniil/homeserver/refs/heads/main/proxmox/monitoring/node_exporter_installer.sh
chmod +x /root/node_exporter_installer.sh
/root/node_exporter_installer.sh

echo "copy configs"
curl -o /root/docker-compose.yml https://raw.githubusercontent.com/SukhovDaniil/homeserver/refs/heads/main/proxmox/monitoring/monitoring.docker-compose.yml
curl -o /root/prometheus.yml https://raw.githubusercontent.com/SukhovDaniil/homeserver/refs/heads/main/proxmox/monitoring/prometheus.yml
curl -o /root/grafana-datasources.yml https://raw.githubusercontent.com/SukhovDaniil/homeserver/refs/heads/main/proxmox/monitoring/grafana-datasources.yml

echo "download grafana dashboards"
mkdir -p /root/grafana/dashboards
curl -o /root/grafana/dashboards/node_exporter.json https://grafana.com/api/dashboards/1860/revisions/42/download

echo "create dirs for monitoring services"
mkdir -p /var/monitoring/{grafana,prometheus}
chmod -R 777 /var/monitoring/

# Because incorrect time trigger errors in prometheus
echo "Turn on systemd-time-wait-sync.service for enable time-sync.target"
systemctl enable systemd-time-wait-sync.service

echo "Set docker compose as system service"
curl -o /etc/systemd/system/monitoringcompose.service https://raw.githubusercontent.com/SukhovDaniil/homeserver/refs/heads/main/proxmox/monitoring/monitoringcompose.service
systemctl daemon-reload
systemctl start monitoringcompose && systemctl enable monitoringcompose