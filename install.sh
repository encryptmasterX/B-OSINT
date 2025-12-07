#!/bin/bash

echo "====================================="
echo "   BOSINT SETUP SCRIPT STARTED"
echo "====================================="
sleep 1

echo "[LOG] Initializing system modules..."
sleep 1
echo "[LOG] Checking repositories..."
sleep 1
echo "[LOG] Loading dependencies..."
sleep 1
echo "[LOG] Preparing installation..."
sleep 2

echo ""
echo ">>> Updating system..."
sudo apt update && sudo apt upgrade -y

echo ""
echo ">>> Installing network tools..."
sudo apt install -y nmap ncat netcat-traditional tcpdump wireshark traceroute

echo ""
echo ">>> Installing DNS & ping tools..."
sudo apt install -y dnsutils iputils-ping arp-scan

echo ""
echo ">>> Installing development tools..."
sudo apt install -y git curl wget python3 python3-pip build-essential

echo ""
echo ">>> Installing utilities..."
sudo apt install -y net-tools htop neofetch unzip zip

echo ""
echo ">>> Installing Web Security scanners..."
sudo apt install -y nikto sqlmap wapiti

echo ""
echo ">>> Installing Password Cracking tools..."
sudo apt install -y john hashcat hydra medusa

echo ""
echo ">>> Giving execute permission to bosint.sh"
chmod +x bosint.sh

echo ""
echo "====================================="
echo "     ✔ DOWNLOAD COMPLETE ✔"
echo "====================================="
