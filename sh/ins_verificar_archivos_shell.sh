#!/bin/bash
# fecha revision   2025-11-05  10:13

# ese script corre en Google Cloud Shell

# abort on any subprocess error
set -eo pipefail

# instalo acceso al storage bucket
source  /home/$USER/cloud-install/sh/common.sh
/home/$USER/cloud-install/sh/ins_buckets_shell.sh


# verifico el repo de la catedra
rm -f /home/$USER/log/ins_common.txt
/home/$USER/cloud-install/sh/ins_common.sh


# verifico secrets
/home/$USER/cloud-install/sh/ins_secrets.sh

# verifico creacion de repo en shell
/home/$USER/cloud-install/sh/ins_crear_repos.sh

# verifico submit a Kaggle
/home/$USER/cloud-install/sh/ins_kaggle_shell.sh

printf "\n\n\n"
printf "Ha finalizado correctamente la verificacion de archivos. Continue con La Gran Instalacion.\n\n"
