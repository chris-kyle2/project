#!/bin/bash

# Exit script on error
set -e

# Initialize Kubernetes master node and capture output
sudo kubeadm init --apiserver-advertise-address $(hostname -I | awk '{print $1}') --pod-network-cidr "10.244.0.0/16" --upload-certs | tee kubeadm-init.log

# Extract the full 'kubeadm join' command
awk '/kubeadm join/{flag=1} flag{print} /\$/{flag=0}' kubeadm-init.log > kubeadm-join-command.txt

# Set up kubeconfig for kubectl
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Verify kubeconfig setup
kubectl cluster-info

# Apply Flannel CNI
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml

# Display the join command
echo "Worker nodes can join using the following command:"
cat kubeadm-join-command.txt

