#!/bin/bash
echo;
echo "Parando serviços virt-manager (libvirtd.socket, libvirtd-admin.socket, libvirtd-ro.socket, libvirtd) "
echo;
sudo systemctl stop libvirtd.socket;
sudo systemctl stop libvirtd-admin.socket;
sudo systemctl stop libvirtd-ro.socket;
sudo systemctl stop libvirtd;

echo "Status dos serviços virt-manager"
sudo systemctl status libvirtd.socket;
sudo systemctl status libvirtd-admin.socket;
sudo systemctl status libvirtd-ro.socket;
sudo systemctl status libvirtd;

echo;
echo "Lista redes do virt manager"
echo;
sudo virsh list --all;


