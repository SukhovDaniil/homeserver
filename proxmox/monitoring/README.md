1. Install [node_exporter](https://prometheus.io/docs/guides/node-exporter/)
   1. copy [installer](node_exporter_installer.sh)
       ```bash
        scp ./proxmox/monitoring/node_exporter_installer.sh root@<ip>:/root/node_exporter_installer.sh
       ```
   2. check endpoints
        ```bash
        curl 192.168.1.103:9100  
        ```

2. Create VM from [Docker-VM community script](https://community-scripts.github.io/ProxmoxVE/scripts?id=docker-vm&category=Containers+%26+Docker)
    ```bash 
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/vm/docker-vm.sh)"
    ```
   System params:
       CPU: 4+ ядер
       RAM: 8-16 GB (8192 MiB)
       Storage: 100-200 GB SSD (зависит от периода хранения)
       Network: 1 Gbps
3. Copy configs
   1. [docker-compose.yml](monitoring.docker-compose.yml) 
   2. [prometheus.yml](prometheus.yml)
4. Set docker compose as system service - [monitoringcompose.service](monitoringcompose.service)