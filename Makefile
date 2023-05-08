#include .env

REGISTRY_USER=${DOCKER_REGISTRY_USER}
REGISTRY_PERSONAL_TOKEN=${DOCKER_REGISTRY_PERSONAL_TOKEN}

IMAGE_TAG=0.1
DIST_PATH=./

IMAGE_NAME=fabiosdsilva/automation-reload-remote-shema-hasura
CONTAINER_NAME=automation-reload-hasura

login:
	@docker login -u ${REGISTRY_USER} -p ${REGISTRY_PERSONAL_TOKEN}

build:
	docker build -t ${IMAGE_NAME} ${DIST_PATH}

tag:
	docker tag ${IMAGE_NAME} ${IMAGE_NAME}:${IMAGE_TAG}

create:
	docker create \
	--env-file ./.env \
	--add-host=host.docker.internal:host-gateway \
	--name ${CONTAINER_NAME} \
	${IMAGE_NAME}

remove: stop
	docker rm ${CONTAINER_NAME}

start:
	docker start ${CONTAINER_NAME}

stop:
	docker stop  ${CONTAINER_NAME}

logs:
	docker logs  ${CONTAINER_NAME}

push:
	docker push ${IMAGE_NAME}:latest 
	docker push ${IMAGE_NAME}:${IMAGE_TAG}

pull-cms:
	docker pull ${IMAGE_NAME}