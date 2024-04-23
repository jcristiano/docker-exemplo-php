#!/bin/bash

export S_CONTAINER_NAME="senai-app-php"


if $( docker ps -a --format '{{.Names}}' | grep -q "^${S_CONTAINER_NAME}\$" ); then    
    docker rm -f "${S_CONTAINER_NAME}"
    echo "Container removido: ${S_CONTAINER_NAME}"
else
    echo "Container ${senai-app-php} não existe"
fi

docker container run -d -p 8080:80 -v /app:/var/www/html