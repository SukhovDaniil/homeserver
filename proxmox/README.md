1. Install Proxmox
2. Node -> Updates -> Repositories
   1. Disable enterprise repositories
   2. Add No-subscription repositories
   3. Update
   4. Reboot
3. Add all additional disks
   1. Format all additional disks if need
      ```bash
      lsblk 
      fdisk ${DISK_PATH} # g (create empty GPT) n (new partition), accept defaults for size/sector, then w (write changes)
      mkfs.ext4 ${DISK_PART}
      ```
   2. Add LVM
4. [Install monitoring](monitoring/README)