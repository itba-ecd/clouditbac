#!/bin/bash
# fecha revision   2025-11-05  10:13

logito="ins_secrets.txt"
# si ya corrio esta seccion, exit
#   [ -e "/home/$USER/log/$logito" ] && exit 0


# requiero que buckets este instalado
[ ! -e "/home/$USER/log/ins_buckets.txt" ] && exit 0


source  /home/$USER/cloud-install/sh/common.sh

# multiples verificaciones

if [ ! -d /home/$USER/install ]; then
    echo "Error Fatal : No existe la carpeta  /home/$USER/install"
    exit 1
fi

if [ ! -d /home/$USER/buckets ]; then
    echo "Error Fatal : No existe la carpeta  /home/$USER/buckets"
    exit 1
fi

if [ ! -d /home/$USER/buckets/b1 ]; then
    echo "Error Fatal : No existe la carpeta  /home/$USER/buckets/b1"
    exit 1
fi


if [ ! -f /home/$USER/buckets/b1/kaggle.json ]; then
    echo "Error Fatal : No existe el archivo  /home/$USER/buckets/b1/kaggle.json"
    exit 1
fi

if ! grep -q username /home/$USER/buckets/b1/kaggle.json; then
    echo "Error Fatal : el archivo kaggle.json no tiene la palabra : username"
    exit 1
fi


if ! grep -q key /home/$USER/buckets/b1/kaggle.json; then
    echo "Error Fatal : el archivo kaggle.json no tiene la palabra : key"
    exit 1
fi

res=$(wc -l < /home/$USER/buckets/b1/kaggle.json)

if [ ! "$res" = "0" ]; then
    echo "Error Fatal : el archivo kaggle.json debe tener una sola linea"
    exit 1
fi



if [ ! -f /home/$USER/buckets/b1/secrets.sh ]; then
    echo "Error Fatal : No existe el archivo  /home/$USER/buckets/b1/secrets.sh"
    exit 1
fi


# conversion a newline de Linux
rm -f /home/$USER/buckets/b1/secrets.bak
mv /home/$USER/buckets/b1/secrets.sh  /home/$USER/buckets/b1/secrets.bak
perl -pe 's/\r\n|\r/\n/g'  /home/$USER/buckets/b1/secrets.bak  > /home/$USER/buckets/b1/secrets.sh
rm /home/$USER/buckets/b1/secrets.bak



# verificacion de los parametros de secrets.sh
if ! grep -q zulip_email /home/$USER/buckets/b1/secrets.sh; then
    echo "Error Fatal : el archivo secrets.sh no tiene el parametro  zulip_email"
    exit 1
fi

if ! grep -q github_usuario /home/$USER/buckets/b1/secrets.sh; then
    echo "Error Fatal : el archivo secrets.sh no tiene el parametro  github_usuario"
    exit 1
fi

if ! grep -q github_token /home/$USER/buckets/b1/secrets.sh; then
    echo "Error Fatal : el archivo secrets.sh no tiene el parametro  github_token"
    exit 1
fi

if ! grep -q github_email /home/$USER/buckets/b1/secrets.sh; then
    echo "Error Fatal : el archivo secrets.sh no tiene el parametro  github_email"
    exit 1
fi

if ! grep -q github_nombre /home/$USER/buckets/b1/secrets.sh; then
    echo "Error Fatal : el archivo secrets.sh no tiene el parametro  github_nombre"
    exit 1
fi


if  ! grep -q github_token='"'ghp_   /home/$USER/buckets/b1/secrets.sh; then
    echo "Error Fatal : el github_token debe comenzar con ghp_"
    exit 1
fi


if  ! grep -E -o -q "\bgithub_email=\"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b"  /home/$USER/buckets/b1/secrets.sh; then
    echo "Error Fatal : el github_email debe tener forma de email"
    exit 1
fi

if  ! grep -E -o -q "\bzulip_email=\"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b"  /home/$USER/buckets/b1/secrets.sh; then
    echo "Error Fatal : el github_email debe tener forma de email"
    exit 1
fi


if  ! grep -q @   /home/$USER/buckets/b1/secrets.sh; then
    echo "Error Fatal : el github_token debe comenzar con ghp_"
    exit 1
fi


if  grep -q “ /home/$USER/buckets/b1/secrets.sh; then
    echo "Error Fatal : el archivo secrets.sh tiene comillas dobles INCLINADAS"
    exit 1
fi

if  grep -q ” /home/$USER/buckets/b1/secrets.sh; then
    echo "Error Fatal : el archivo secrets.sh tiene comillas dobles INCLINADAS"
    exit 1
fi

if  grep -q "'" /home/$USER/buckets/b1/secrets.sh; then
    echo "Error Fatal : el archivo secrets.sh no tiene comillas simples, y solo debe tener dobles"
    exit 1
fi




cp  /home/$USER/buckets/b1/secrets.sh   /home/$USER/install/
chmod u+x  /home/$USER/install/secrets.sh


source  /home/$USER/buckets/b1/secrets.sh

rm -rf  /home/$USER/tmp
mkdir -p /home/$USER/tmp

wget https://github.com/$github_usuario -O  /home/$USER/tmp/caca
if [ ! $? -eq 0 ]; then
  rm -rf  /home/$USER/tmp
  echo "Error Fatal: no existe el usuario $github_usuario  en GitHub"
  exit 1
fi


wget https://github.com/$github_usuario/$github_catedra_repo -O  /home/$USER/tmp/caca
if [ ! $? -eq 0 ]; then
  rm -rf  /home/$USER/tmp
  echo "Error Fatal: no existe el repo $github_usuario/$github_catedra_repo  en GitHub"
  exit 1
fi


response=$(curl -s -w "%{http_code}" -H "Authorization: Bearer $github_token" "https://api.github.com")
http_code=$(tail -n1 <<< "$response")
if [ ! $http_code -eq "200" ]; then
  rm -rf  /home/$USER/tmp
  echo "Error Fatal: el token_github NO es reconocido por www.github.com"
  exit 1
fi



rm -rf /home/$USER/.kaggle
mkdir -p /home/$USER/.kaggle
cp  /home/$USER/buckets/b1/kaggle.json   /home/$USER/.kaggle/
chmod 600 /home/$USER/.kaggle/kaggle.json



# grabo
fecha=$(date +"%Y%m%d %H%M%S")
echo $fecha > /home/$USER/log/$logito

exit 0