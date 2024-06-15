#!/bin/bash
echo;
echo "Criando rede br10.xml arquivo"
echo;
echo "<network>" > br10.xml;
  echo "<name>br10</name>" >> br10.xml;
  echo "<forward mode='nat'>" >> br10.xml;
    echo "<nat>" >> br10.xml;
      echo "<port start='1024' end='65535'/>" >> br10.xml;
    echo "</nat>" >> br10.xml;
  echo "</forward>" >> br10.xml;
  echo "<bridge name='br10' stp='on' delay='0'/>" >> br10.xml;
  echo "<ip address='192.168.30.1' netmask='255.255.255.0'>" >> br10.xml;
    echo "<dhcp>" >> br10.xml;
      echo "<range start='192.168.30.50' end='192.168.30.200'/>" >> br10.xml;
    echo "</dhcp>" >> br10.xml;
  echo "</ip>" >> br10.xml;
echo "</network>" >> br10.xml;

sudo echo "Desligando rede por segurança";
sudo echo "";
sudo echo "sudo nmcli networking off;";
sudo service network-manager stop;
sudo systemctl stop NetworkManager;
sudo nmcli networking off;
sudo echo "";


echo;
echo "Restartando serviços virt-manager"
echo;
sudo systemctl stop libvirtd.socket;
sudo systemctl stop libvirtd-admin.socket;
sudo systemctl stop libvirtd-ro.socket;
sudo systemctl stop libvirtd;

sudo systemctl status libvirtd.socket;
sudo systemctl status libvirtd-admin.socket;
sudo systemctl status libvirtd-ro.socket;

sudo systemctl stop libvirtd;
sudo systemctl disable libvirtd;
sudo systemctl enable libvirtd;
sudo systemctl start libvirtd;
sudo systemctl restart libvirtd;
sudo systemctl status libvirtd;

sudo systemctl start libvirtd.socket;
sudo systemctl start libvirtd-admin.socket;
sudo systemctl start libvirtd-ro.socket;
sudo systemctl restart libvirtd.socket;
sudo systemctl restart libvirtd-admin.socket;
sudo systemctl restart libvirtd-ro.socket;

echo;
echo "Apagando regras do firewall"
echo;
sudo iptables -F  # Remove as regras de todas as chains
sudo iptables -X  # Apaga todas as chains
sudo iptables -Z  # Zera as regras de todas as chains
sudo iptables -P INPUT ACCEPT;
sudo iptables -P FORWARD ACCEPT;
sudo iptables -P OUTPUT ACCEPT;
sudo iptables -t filter -F;
sudo iptables -t filter -X;
sudo iptables -t filter -Z;
sudo iptables -t nat -F;
sudo iptables -t nat -X;
sudo iptables -t nat -Z;
sudo iptables -t mangle -F;
sudo iptables -t mangle -X;
sudo iptables -t mangle -Z;
sudo iptables -t raw -F;
sudo iptables -t raw -X;
sudo iptables -t raw -Z;

echo;
echo "Liberando encaminhamento IP (ip forward)"
echo;
sudo echo "Comando: sudo echo 1 > /proc/sys/net/ipv4/ip_forward";
sudo echo 1 > /proc/sys/net/ipv4/ip_forward;
sudo echo "";

sudo echo "Checando com cat /proc/sys/net/ipv4/ip_forward";
sudo echo "Precisa estar 1";
cat /proc/sys/net/ipv4/ip_forward;
sudo echo "";

echo;
echo "Configurando virt-manager"
echo;
sudo virsh list --all;
sudo virsh net-define  br10.xml;
sudo virsh net-start br10;
sudo virsh net-autostart br10;
ip addr show dev br10;

sudo echo "Religa rede";
sudo echo "";
sudo service network-manager stop;
sudo service network-manager start;
sudo service network-manager restart;
sudo systemctl stop NetworkManager;
sudo systemctl disable NetworkManager;
sudo systemctl enable NetworkManager;
sudo systemctl start NetworkManager;
sudo systemctl restart NetworkManager;
sudo nmcli networking off;
sudo nmcli networking on;
sudo echo;

sudo echo "";
echo "############################ LISTA REGRAS IPTABLES ############################"
sudo echo "";
sudo echo "############################ Table Filter ############################";
sudo iptables -t filter -S;
sudo echo "";

sudo echo "############################ Table Nat ############################";
sudo iptables -t nat -S;
sudo echo "";

sudo echo "############################ Table Mangle ############################";
sudo iptables -t mangle -S;
sudo echo "";

sudo echo "############################ Table Raw ############################";
sudo iptables -t raw -S;
sudo echo "############################ FIM LISTAR REGRAS IPTABLES ############################";
sudo echo "";

echo;
echo "Lista redes do virt manager"
echo;
sudo virsh list --all;


