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
3. Install fdisk
4. Add disk for monitoring data
   Add -> backup=0,discard=on,size=150G,ssd=1
   ```shell
   fdisk /dev/sdb
   mkfs.ext4 /dev/sdb1
   mkdir -p /var/monitoring
   mount -t auto /dev/sdb1 /var/monitoring/
   cp /etc/fstab /etc/~fstab
   echo "UUID=$(blkid /dev/sdb1 | awk '{print $2}' | awk -F= '{print $2}' | sed 's/"//g') /var/monitoring ext4 defaults 0 0" >> /etc/fstab
   ```
5. Install wget
6. Configure monitoring
    ```shell
    curl -o /root/docker-monitoring.installer.sh https://raw.githubusercontent.com/SukhovDaniil/homeserver/refs/heads/main/proxmox/monitoring/docker-monitoring.installer.sh
    chmod +x /root/docker-monitoring.installer.sh
    /root/docker-monitoring.installer.sh
    ```