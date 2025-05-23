
# Autorizar execução com chmod:


sudo chmod +x virt_manager_br11.sh;


sudo chmod +x virt_manager_br10.sh;


sudo chmod +x virt_manager_delete.sh;


sudo chmod +x virt_manager_stop.sh;


sudo chmod +x virt_manager_start.sh;


# Executando

- cria rede br11 (do vídeo https://www.youtube.com/watch?v=nuBAgEK1eCY&t=2s).

sudo ./virt_manager_br11.sh;


- cria rede br10 de apenas 2 ips.

sudo ./virt_manager_br10.sh;


- deleta rede br10.

sudo ./virt_manager_delete.sh;


- para virt_manager, se não estiver usando pare o serviço por segurança.

sudo ./virt_manager_stop.sh;


- Restarta o virt manager para voltar a usar.

sudo ./virt_manager_start.sh;



> Problema (issue) no virt-manager no Linux! Após configurar outras regras de firewall para uso em outros fins e apagar todas as regras criadas pelo virt-manager-kvm ou qemu pela interface gráfica, você não consegue mais apagar as regras do iptables para criar as regras devidas para a máquina virtual qemu virt-manager funcionar. Isso ocorre no Linux! O vídeo abaixo soluciona isso por linha de comando pelo terminal, mas é muito trabalho e demorado. Desenvolvi esses scripts que resolvem todo o problema. Vídeo abaixo! Se o script /virt_manager_delete.sh não destruir a rede br10 para reconfiguração da mesma, faça manualmente a destruição dela usando.


sudo virt-manager;


Vá em network e apagar manualmente pela interface gráfica.

## Vídeo Tutorial e artigo completo

https://traderprofissional.com.br/virt-manager-linux-nat.aspx

https://www.youtube.com/watch?v=nuBAgEK1eCY&t=2s



# Doe monero para nos ajudar: (donate XMR)

    87JGuuwXzoMGwQAcSD7cvS7D7iacPpN2f5bVqETbUvCgdEmrPZa12gh5DSiKKRgdU7c5n5x1UvZLj8PQ7AAJSso5CQxgjak




Página oficial de segurança digital:


https://traderprofissional.com.br/seguranca-digital.aspx


