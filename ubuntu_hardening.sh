#!/bin/bash

# ==========================================
# Ubuntu GUI Based Hardening Script
# Organization Context: NTRO
# ==========================================

LOG_DIR="./logs"
LOG_FILE="$LOG_DIR/hardening.log"

mkdir -p "$LOG_DIR"
touch "$LOG_FILE"

exec > >(tee -a "$LOG_FILE") 2>&1

# Root check
if [[ $EUID -ne 0 ]]; then
  zenity --error --text="Please run this script as root (sudo)"
  exit 1
fi

# ------------------------------
# Hardening Functions
# ------------------------------

disable_ssh() {
  systemctl stop ssh
  systemctl disable ssh
  echo "[+] SSH disabled"
}

block_usb() {
  echo "blacklist usb-storage" > /etc/modprobe.d/usbblock.conf
  modprobe -r usb-storage
  echo "[+] USB storage blocked"
}

enable_firewall() {
  ufw default deny incoming
  ufw default allow outgoing
  ufw enable
  echo "[+] Firewall enabled"
}

block_tor() {
  echo "127.0.0.1 torproject.org" >> /etc/hosts
  echo "[+] TOR blocked"
}

set_grub_password() {
  zenity --info --text="Run 'grub-mkpasswd-pbkdf2' manually to generate password hash"
  grub-mkpasswd-pbkdf2
}

password_policy() {
  sed -i 's/^# minlen.*/minlen = 12/' /etc/security/pwquality.conf
  sed -i 's/^# dcredit.*/dcredit = -1/' /etc/security/pwquality.conf
  sed -i 's/^# ucredit.*/ucredit = -1/' /etc/security/pwquality.conf
  echo "[+] Strong password policy applied"
}

# ------------------------------
# GUI Menu
# ------------------------------

OPTIONS=$(zenity --list --checklist \
  --title="Ubuntu OS Hardening Tool" \
  --text="Select security policies to apply:" \
  --width=500 --height=400 \
  --column="Select" --column="Policy" \
  FALSE "Disable SSH" \
  FALSE "Block USB Storage" \
  FALSE "Enable Firewall" \
  FALSE "Block TOR Network" \
  FALSE "Set GRUB Password" \
  FALSE "Enforce Password Policy")

# ------------------------------
# Apply Selected Policies
# ------------------------------

IFS="|" read -ra SELECTED <<< "$OPTIONS"

for policy in "${SELECTED[@]}"; do
  case $policy in
    "Disable SSH") disable_ssh ;;
    "Block USB Storage") block_usb ;;
    "Enable Firewall") enable_firewall ;;
    "Block TOR Network") block_tor ;;
    "Set GRUB Password") set_grub_password ;;
    "Enforce Password Policy") password_policy ;;
  esac
done

zenity --info --text="Hardening completed successfully!\nLog file: $LOG_FILE"
