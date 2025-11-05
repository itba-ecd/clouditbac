#!/bin/bash

source  /home/$USER/cloud-install/sh/common.sh



MY_PROJECT_ID=$(gcloud projects list --filter="projectId~$gcprojectprefix AND lifecycleState:ACTIVE" --format="value(projectId)")
gcloud config set project $MY_PROJECT_ID


myserviceaccount=$(gcloud iam service-accounts list --format='value(EMAIL)' | head -1)


# instance-instalacion STANDARD creacion
gcloud compute instances create instance-instalacion \
    --project="$MY_PROJECT_ID" \
    --zone=us-west4-c \
    --machine-type=t2d-standard-8 \
    --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default \
    --maintenance-policy=TERMINATE \
    --provisioning-model=STANDARD \
    --service-account="$myserviceaccount" \
    --scopes=https://www.googleapis.com/auth/cloud-platform \
    --tags=https-server,http-server \
    --create-disk=auto-delete=yes,boot=yes,device-name=instance-instalacion,image=projects/ubuntu-os-cloud/global/images/ubuntu-minimal-2404-noble-amd64-v20251020,mode=rw,size=64,type=pd-balanced \
    --no-shielded-secure-boot \
    --shielded-vtpm \
    --shielded-integrity-monitoring \
    --labels=goog-ec-src=vm_add-gcloud \
    --reservation-affinity=any



echo
echo "Esperando 45 segundos a que se inicie la virtual machine  instance-instalacion"
sleep 45

rm -rf /home/$USER/.ssh
mkdir -p /home/$USER/.ssh
ssh-keygen -t rsa -f  /home/$USER/.ssh/google_compute_engine -C $USER  -q -N ""


MY_PROJECT_ID=$(gcloud projects list --filter="projectId~$gcprojectprefix AND lifecycleState:ACTIVE" --format="value(projectId)")
gcloud config set project $MY_PROJECT_ID

gcloud --quiet compute ssh "$USER"@instance-instalacion \
    --zone=us-west4-c \
    --project="$MY_PROJECT_ID" \
    --command="bash -s" < /home/$USER/cloud-install/sh/pre_main01.sh 


echo "Esperando 5 segundos"
sleep 5


MY_PROJECT_ID=$(gcloud projects list --filter="projectId~$gcprojectprefix AND lifecycleState:ACTIVE" --format="value(projectId)")
gcloud config set project $MY_PROJECT_ID

gcloud compute ssh "$USER"@instance-instalacion \
    --zone=us-west4-c \
    --project="$MY_PROJECT_ID" \
    --command="bash -s" <  /home/$USER/cloud-install/sh/ins_tmux_main02.sh
