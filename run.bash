#!/bin/bash

set -x

S_CONTAINER_NAME="senai-app-php"
S_IMAGE_NAME="senai-jcmsilv-conuv-php:0.0.1"

function fn_container_is_running(){
    local s_container_name=${1}    
    docker ps --format '{{.Names}}' | grep -q "^${s_container_name}\$"
    if [[ $? -eq 0 ]]; then
        return 1
    fi
    return 0    
}

function fn_container_exists(){
    local s_container_name=${1}    
    docker ps -a --format '{{.Names}}' | grep -q "^${s_container_name}\$"
    if [[ $? -eq 0 ]]; then
        return 1
    fi
    return 0    
}

function fn_image_exists(){
    local s_image_name=${1}
    docker ps -a --format '{{.Names}}' | grep -q "^${s_image_name}\$"
    if [[ $? -eq 0 ]]; then
        return 1
    fi
    return 0
}

function fn_main(){
    
    function fn_parar_container() {
        fn_container_is_running ${S_CONTAINER_NAME}
        if [[ $? -eq 1 ]]; then
            echo "Parando o container: ${S_CONTAINER_NAME}"
            docker container stop "${S_CONTAINER_NAME}"
        fi
    }

    function fn_remover_container(){
        fn_container_exists ${S_CONTAINER_NAME}
        if [[ $? -eq 1 ]]; then
            echo "Removendo o container: ${S_CONTAINER_NAME}"
            docker container rm -f "${S_CONTAINER_NAME}"
        fi
    }

    fn_parar_container
    fn_remover_container
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