#!/bin/bash
echo;
echo "Parando serviços virt-manager (libvirtd.socket, libvirtd-admin.socket, libvirtd-ro.socket, libvirtd) "
echo;
sudo systemctl start libvirtd.socket;
sudo systemctl start libvirtd-admin.socket;
sudo systemctl start libvirtd-ro.socket;
sudo systemctl start libvirtd;
sudo systemctl restart libvirtd.socket;
sudo systemctl restart libvirtd-admin.socket;
sudo systemctl restart libvirtd-ro.socket;
sudo systemctl restart libvirtd;

echo "Status dos serviços virt-manager"
sudo systemctl status libvirtd.socket;
sudo systemctl status libvirtd-admin.socket;
sudo systemctl status libvirtd-ro.socket;
sudo systemctl status libvirtd;

echo;
echo "Lista redes do virt manager"
echo;
sudo virsh list --all;


