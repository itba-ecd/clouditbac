#!/bin/bash
# fecha revision   2025-11-05  10:13

webfiles="https://storage.googleapis.com/open-courses/itba2025-8d0a"


gcprojectprefix="itbaecd-"
gcprojectname="itba-dm2025c"

dataset1="gerencial_competencia_2025.csv.gz"
dataset2="analistajr_competencia_2025.csv.gz"
dataset3="analistasr_competencia_2025.csv.gz"
dataset4="dataset_pequeno.csv"
pseudopublic="list"

export zulipbot="GoogleCloud-bot@itba2025.zulip.rebelare.com:xb65CMzjd4UHvqLYTIpeKrExaED0oxOZ"
export zulipurl="https://itba2025.zulip.rebelare.com/api/v1/messages"


kaggleprueba="102_kaggle_prueba.r"

kaggle_competencia_peque="data-mining-pequena-2025-c"
kaggle_competencia_sr="data-mining-analista-sr-2025-c"
kaggle_competencia_jr="data-mining-analista-jr-2025-c"
kaggle_competencia_mgr="data-mining-gerencial-2025-c"
kaggle_ok="Successfully submitted to Data Mining, Pequena 2025 C"

export github_catedra_user="itba-ecd"
export github_catedra_repo="dm2025c"
export github_install_repo="clouditbac"

export mlflow_usuario="itba2025c"
export mlflow_clave="constructivism"

repo_check_directory="src/rpart"
repo_check_file="z102_FinalTrain.ipynb"

tabulador="	"
logfile="/home/$USER/install/log_install.txt"

MIHOST=$(echo $HOSTNAME | /usr/bin/cut -d . -f1)

bitacora () {
  local fecha=$(date +"%Y%m%d %H%M%S")

  echo "$fecha""$tabulador""$1"  >>  "$logfile"
}
