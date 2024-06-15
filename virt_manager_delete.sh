#!/bin/bash
echo;
echo "Deletando Redes do virt-manager"
sudo echo "Desligando rede por segurança";
sudo echo "sudo nmcli networking off;";
sudo service network-manager stop;
sudo systemctl stop NetworkManager;
sudo nmcli networking off;

echo;
sudo virsh list --all;
sudo virsh net-list;
sudo virsh net-destroy br10;
sudo virsh net-destroy br11;
sudo virsh list --all;
sudo virsh net-list;

#IPTABLES CONFIGURAÇÃO PRINCIPAL - 

#Desabilitando o tráfego entre as placas - impede compartilhamento de conexão do pc para placa rj45 externa ou wifi de ponto de acesso
#Precisa criar uma opção de script com sudo echo 1 > /proc/sys/net/ipv4/ip_forward; para permiter placa externa e ponto #de acesso funcionar.
sudo echo 0 > /proc/sys/net/ipv4/ip_forward;

#Proteção contra ping, SYN Cookies, IP Spooﬁng e proteções do kernel
sudo echo 1 > /proc/sys/net/ipv4/tcp_syncookies;

# Syn Flood (DoS) # Port scanners
sudo echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts; 

#Redirecionamento seguro de pacotes
sudo echo 1 > $i/secure_redirects; 

# Broadcast echo protection enabled.
sudo echo 0 > /proc/sys/net/ipv4/conf/all/forwarding;

# Log strange packets.
sudo echo 1 >/proc/sys/net/ipv4/conf/all/log_martians;

# Bad error message protection enabled..
sudo echo 1 > /proc/sys/net/ipv4/icmp_ignore_bogus_error_responses; 

# IP spoofing protection.
sudo echo 1 > /proc/sys/net/ipv4/conf/all/rp_filter;

# Disable ICMP redirect acceptance.
sudo echo 0 > /proc/sys/net/ipv4/conf/all/accept_redirects;
sudo echo 0 > /proc/sys/net/ipv4/conf/all/send_redirects;

# Disable source routed packets.
sudo echo 0 > /proc/sys/net/ipv4/conf/all/accept_source_route;

#Sem tracert e ping
sudo echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all;

echo "Apagando regras do iptables sudo iptables -F, -X e -Z para todas as tabelas"
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


sudo echo "";


# Definindo políticas padrões
######################
sudo iptables  -P  INPUT DROP  # iptables a política padrão da chain INPUT é proibir tudo
sudo iptables  -P  FORWARD DROP
sudo iptables  -P  OUTPUT ACCEPT


# Liberando a Loopback
####################
sudo iptables -A  INPUT -i lo -j ACCEPT
sudo iptables -A  FORWARD -i lo -j DROP

## Regras de segurança na internet e acessos
## ethx tem que mudar, use ifconfig e cheque qual é, no caso ether
#####################################
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j DROP

#Bloqueando novas conexões e conexões invalidas após ter a conexão estabelecida e relatada
sudo iptables -A INPUT -m state --state INVALID -j DROP
sudo iptables -A FORWARD -m state --state INVALID -j DROP
sudo iptables -A INPUT -m state --state NEW -j DROP

#SOMENTE PCS DENTRO DA REDE PODEM SE CONECTAR
sudo iptables -A INPUT -p tcp --syn -s 192.168.0.0/255.255.255.0 -j ACCEPT;
sudo iptables -A INPUT -p tcp --syn -j DROP;
sudo iptables -A INPUT -i ppp0 -p udp --dport 0:30000 -j DROP;

sudo echo "";

#REATIVA NETWORK REDE
sudo echo "REATIVA NETWORK REDE";
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

sudo echo "Lista Redes Virt-manager";
sudo virsh list --all;
sudo virsh net-list;

