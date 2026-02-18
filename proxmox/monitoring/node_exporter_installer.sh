cd ~

wget https://github.com/prometheus/node_exporter/releases/download/v1.10.2/node_exporter-1.10.2.linux-amd64.tar.gz
tar xvfz ./node_exporter-1.10.2.linux-amd64.tar.gz
cp ./node_exporter-1.10.2.linux-amd64/node_exporter /usr/bin/node_exporter
rm -fr ./node_exporter-1.10.2.linux-amd64

useradd -M --shell /sbin/nologin node_exporter || true

cat << EOF > /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
ExecStart=/usr/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start node_exporter && systemctl enable node_exporter
