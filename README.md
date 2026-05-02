# 🧩 NixOS Installation Guide

This guide describes the full process of installing and configuring NixOS with flakes and Home Manager.

---

## 📌 Step 1: Disk preparation

```bash
sudo -i
```

```bash
lsblk
```

Use the lsblk command to check your disk name and use it instead of "sda" when proceeding to the next steps. Pay attention to change all your personal info like username, host, and mount points

```bash
cfdisk /dev/nvme0n1
```
Create a 1GiB partition of type EFI system

Allocate the rest as a Linux filesystem

Write, yes

Quit

---

## 📌 Step 2: Partition formatting

```bash
lsblk
```

```bash
mkfs.ext4 -L nixos /dev/nvme0n1p2
```

```bash
mkfs.fat -F 32 -n BOOT /dev/nvme0n1p1
```

---

## 📌 Step 3: Mount filesystems

```bash
mount /dev/nvme0n1p2 /mnt
```

```bash
mount --mkdir /dev/nvme0n1p2 /mnt/boot
```

---

## 📌 Step 4: Set date and time

Use **one** of the commands below:

```bash
timedatectl set-timezone America/Bahia
```

or

```bash
date -s "2026-04-28 09:50:00"
```

---

## 📌 Step 5: Generate NixOS configuration

```bash
nixos-generate-config --root /mnt
```

---

## 📌 Step 6: Copy configs

Mount a removable device in /mnt

```bash
mkdir /mnt/Ventoy
```

```bash
lsblk
```

```bash
mount /dev/sdb2 /mnt/Ventoy
```

```bash
cp /mnt/Ventoy/Nix/* /mnt/etc/nixos/
```


Or clone from online repository

```bash
cd /tmp
```

```bash
git clone https://github.com/pbelem/Nix
```

```bash
cp /tmp/Nix/* /mnt/etc/nixos
```

Remove README.md

```bash
rm /mnt/etc/nixos/README.md
```


---

## 📌 Step 7: Initialize git repository

```bash
cd /mnt/etc/nixos
```

```bash
git init
```

```bash
git add .
```

---

## 📌 Step 8: Install NixOS with flake

```bash
nixos-install --root /mnt --flake /mnt/etc/nixos#Desktop-NixOS
```

---

## 📌 Step 9: Set user password and reboot

```bash
nixos-enter --root /mnt -c 'passwd belem'
```

```bash
reboot
```

---


## 📌 Step 11: 

### (q) Quit and do nothing

```bash
sudo chown -R belem:users /etc/nixos
```

If you are using my configuration.nix file, you can use my alias "nrhm" instead of the next command

```bash
nix run home-manager/release-25.11 -- switch --flake /etc/nixos#belem
```

```bash
rebot
```

## 📌 Step 12: Post-installation

Launch noctalia for the first time

super + enter

```bash
uwsm app -- noctalia-shell & disown
```

---

## ✅ Done

After these steps, your NixOS system will be installed.
