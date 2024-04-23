#!/bin/bash

set -x

S_CONTAINER_NAME="senai-app-php"
S_IMAGE_NAME="senai-jcmsilv-conuv-php:0.0.1"

function fn_container_is_running(){
    local s_container_name=${1}
    if [[ docker ps --format '{{.Names}}' | grep -q "^${s_container_name}\$" ]]; then
        return 1
    fi
    return 0    
}

function fn_image_exists(){
    local s_image_name=${1}
    if [[ docker ps -a --format '{{.Names}}' | grep -q "^${s_image_name}\$" ]];
        return 1
    fi
    return 0
}

function fn_main(){
    if [[ fn_container_is_running ${S_CONTAINER_NAME} -eq 1 ]]; then
        echo "Parando o container: ${S_CONTAINER_NAME}"
        docker container stop "${S_CONTAINER_NAME}"
    fi
}

fn_main
exit 0
if $( docker ps -a --format '{{.Names}}' | grep -q "^${S_CONTAINER_NAME}\$" ); then
    docker container stop "${}"    
    docker rm -f "${S_CONTAINER_NAME}"
    echo "Container removido: ${S_CONTAINER_NAME}"
else
    echo "Container ${senai-app-php} não existe"
fi

docker container run \
    --name "${S_CONTAINER_NAME}" \
    -d -p 8080:80 -v /app:/var/www/html \
    "${S_IMAGE_NAME}"