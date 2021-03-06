#!/bin/bash
if [ ! "$BASH" ]
then
echo "Este script foi feito para funcionar com o bash
Reiniciando o Script usando BASH em 3 segundos..."
sleep 3
bash $0 $@
exit $?
fi
clear
menu="\033[41;1;37m"
corPadrao="\033[0m"
preto="\033[0;30m"
vermelho="\033[0;31m"
verde="\033[0;32m"
marrom="\033[0;33m"
azul="\033[0;34m"
purple="\033[0;35m"
cyan="\033[0;36m"
cinzaClaro="\033[0;37m"
pretoCinza="\033[1;30m"
vermelhoClaro="\033[1;31m"
verdeClaro="\033[1;32m"
amarelo="\033[1;33m"
azulClaro="\033[1;34m"
purpleClaro="\033[1;35m"
cyanClaro="\033[1;36m"
branco="\033[1;37m"
fim="\033[0m"

echo -e "$menu
                        SQUID                  $fim"

echo -e "$cyanClaro
Este é um script que configura uma nova versão do SQUID para sistemas Debian-Based.
Neste script não a nenhuma garantia de funcionamento ou suporte do autor.
$fim"
read -p "Pressione Qualquer Tecla para Continuar..."
read -p "Digite seu IP: " ip
echo -e "$cyanClaro
Instalando SQUID...$fim"
apt-get update 1>/dev/null 2>/dev/null
apt-get upgrade -y 1>/dev/null 2>/dev/null
apt-get install squid -y 1>/dev/null 2>/dev/null

echo -e "$azulClaro
Configurando SQUID...$fim"

echo "# Portas do SQUID
http_port 80
http_port 8080
http_port 3128

# ACLs e Liberações
acl accept dstdomain -i $ip
acl allowed dstdomain -i /etc/payloads
acl combr dstdomain -i .com.br
acl com dstdomain -i .com
#acl all src 0.0.0.0/0.0.0.0
http_access allow accept
http_access allow allowed
http_access allow combr
http_access allow com
http_access deny all
always_direct allow all

# Anonimo
forwarded_for off

# Pipeline
#pipeline_prefetch on
" > /etc/squid/squid.conf

echo -e "$azulClaro
Configurando SSH...$fim"

echo -e "

Port 443" >> /etc/ssh/sshd_config
echo -e "
.bookclaro.com.br
.claro.com.ar
.claro.com.br
.claro.com.co
.claro.com.ec
.claro.com.gt
.claro.com.ni
.claro.com.pe
.claro.com.sv
.claro.cr
.clarocurtas.com.br
.claroideas.com
.claroideias.com.br
.claromusica.com
.clarosomdechamada.com.br
.clarovideo.com
.facebook.net
.netclaro.com.br
.oi.com.br
.oimusica.com.br
.speedtest.net
.tim.com.br
.timanamaria.com.br
.vivo.com.br
.d1n212ccp6ldpw.cloudfront.net
.rdio.com
.ec2-52-22-60-103.compute-1.amazonaws.com
.portalrecarga.vivo.com.br/recarga/home/
.w1716.smartadserver.com
interatividade.vivo.ddivulga.com/produto
navegue.vivo.ddivulga.com/pacote
.m.clarosomdechamada.com.br
m.clarosomdechamada.com.br
.clarosomdechamada.com.br
.portalsva2.vivo.com.br" > /etc/payloads

echo -e "$cyanClaro
Recarregando serviços...$fim"
squid -k reconfigure 1>/dev/null 2>/dev/null
service ssh restart 1>/dev/null 2>/dev/null
service squid restart 1>/dev/null 2>/dev/null

# echo -e "$verde
# Correção de problemas de pacotes no SSH...$fim"
# apt-get install ethtool -y 1>/dev/null 2>/dev/null
# read -p "Digite o nome da sua interface de rede (Padrão: eth0): " interface
# if [ "$interface" = "" ]
# then
# interface=eth0
# fi
# ethtool -G $interface rx 999999999 tx 999999999 1>/dev/null 2>/dev/null


echo -e "$verde
Configuração terminada.$fim"

echo -e "$menu
By: telegram.me/@C_layder_son$fim"
