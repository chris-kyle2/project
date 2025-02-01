#!/bin/bash
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# Disable swap
sudo swapoff -a

# To make it persistent across reboots, edit fstab
sudo sed -i '/swap/d' /etc/fstab

# Load the br_netfilter module
sudo modprobe br_netfilter

# Enable the required sysctl parameters
sudo sysctl net.bridge.bridge-nf-call-iptables=1
sudo sysctl net.bridge.bridge-nf-call-ip6tables=1

# Enable IP forwarding (required for Kubernetes networking)
sudo sysctl net.ipv4.ip_forward=1

# Make these settings persistent across reboots
echo "br_netfilter" | sudo tee -a /etc/modules-load.d/modules.conf
echo "net.bridge.bridge-nf-call-iptables = 1" | sudo tee -a /etc/sysctl.conf
echo "net.bridge.bridge-nf-call-ip6tables = 1" | sudo tee -a /etc/sysctl.conf
echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf

# Apply the sysctl changes
sudo sysctl -p

# Update package list
sudo apt update

# Install containerd
sudo apt install -y containerd

# Enable and start containerd service
sudo systemctl enable containerd
sudo systemctl start containerd

echo "ps -p 1"
sudo mkdir -p /etc/containerd

# Generate containerd config and overwrite config.toml
containerd config default | sudo tee /etc/containerd/config.toml > /dev/null

# Update SystemdCgroup setting in config.toml
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml

# Restart containerd to apply changes
sudo systemctl restart containerd

# Switch back to ubuntu user (Not needed in a script, but if required, use su -c)
sudo su - ubuntu -c "cd /home/ubuntu && echo 'Switched to ubuntu user'"




