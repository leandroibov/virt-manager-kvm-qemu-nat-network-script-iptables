Hashs:

9dbfe3d765442dd651d7ef4f323ae16747d5eb47f425790fea83773b948cafea ./virt_manager_br11.sh


bf43bc07a6098b377aa834c851b239e357ee8e92b2c2d3b1e5a89d50d09b319e ./virt_manager_br10.sh


91329fa7c2e0981fce6add33467e2bb441e360ce50a03860e7d7624bfa83341e ./virt_manager_delete.sh



#Autorizar execução com chmod:


sudo chmod +x virt_manager_br11.sh;


sudo chmod +x virt_manager_br10.sh;


sudo chmod +x virt_manager_delete.sh;


sudo chmod +x virt_manager_stop.sh;


sudo chmod +x virt_manager_start.sh;


#Executando

#cria rede br11 (do vídeo https://www.youtube.com/watch?v=nuBAgEK1eCY&t=2s).

sudo ./virt_manager_br11.sh;


#cria rede br10 de apenas 2 ips.

sudo ./virt_manager_br10.sh;


#deleta rede br10.

sudo ./virt_manager_delete.sh;


#para virt_manager, se não estiver usando pare o serviço por segurança.

sudo ./virt_manager_stop.sh;


#Restarta o virt manager para voltar a usar.

sudo ./virt_manager_start.sh;



Problema (issue) no virt-manager no Linux! Após configurar outras regras de firewall para uso em outros fins e apagar todas as regras criadas pelo virt-manager-kvm ou qemu pela interface gráfica, você não consegue mais apagar as regras do iptables para criar as regras devidas para a máquina virtual qemu virt-manager funcionar. Isso ocorre no Linux! O vídeo abaixo soluciona isso por linha de comando pelo terminal, mas é muito trabalho e demorado. Desenvolvi esses scripts que resolvem todo o problema. Vídeo abaixo! Se o script /virt_manager_delete.sh não destruir a rede br10 para reconfiguração da mesma, faça manualmente a destruição dela usando.


sudo virt-manager;


Vá em network e apagar manualmente pela interface gráfica.

https://www.youtube.com/watch?v=nuBAgEK1eCY&t=2s
