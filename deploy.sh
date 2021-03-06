#!/usr/bin/env bash

if [ "$TRAVIS_BRANCH" == "master" ]; then
    mvn clean deploy --settings settings.xml -DskipTests

    SHA_SHORT=`git rev-parse --short HEAD`

    docker_image="TeamLegendary/ReadingListService:${SHA_SHORT}_dev"
    docker_latest="TeamLegendary/ReadingListService"

    docker tag -f ${docker_image} ${docker_latest}

    docker login -e ${DOCKER_EMAIL} -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
    docker push ${docker_image}
    docker push ${docker_latest}
fi