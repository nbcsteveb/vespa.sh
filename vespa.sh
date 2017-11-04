#!/bin/bash
VESPA_SAMPLE_APPS=./sample-apps

function run_vespa_container {
    docker-compose up -d
}

function wait_for_server {
    while true; do
        docker-compose exec vespa bash -c 'curl -s --head http://localhost:19071/ApplicationStatus' | grep "HTTP/1.1 200 OK" > /dev/null;
        if [ $? -eq 0 ]; then
            break;
        fi
        sleep 1;
    done;
}

function wait_for_sample_app {
    while true; do
        curl -s --head "http://localhost:8080/ApplicationStatus" | grep "HTTP/1.1 200 OK" > /dev/null;
        if [ $? -eq 0 ]; then
            break;
        fi
        sleep 1;
    done;
}

function deploy_sample_app {
    docker-compose exec vespa bash -c '/opt/vespa/bin/vespa-deploy prepare /vespa-sample-apps/basic-search/src/main/application/ && /opt/vespa/bin/vespa-deploy activate'
}

function feed_documents {
    curl -s -X POST --data-binary @"${VESPA_SAMPLE_APPS}/basic-search/music-data-1.json" "http://localhost:8080/document/v1/music/music/docid/1" | python -m json.tool && \
    curl -s -X POST --data-binary @"${VESPA_SAMPLE_APPS}/basic-search/music-data-2.json" "http://localhost:8080/document/v1/music/music/docid/2" | python -m json.tool;
}

echo "[.] Starting Vespa Container.." && \
    run_vespa_container && wait_for_server && \
echo "[.] Server is running!" && \
echo "[.] Deploying sample app.." && \
    deploy_sample_app && wait_for_sample_app && \
echo "[.] Sample app is running!"
echo "[.] Feeding documents.."
    feed_documents;

echo "[.] Ready! Try some commands:"
printf "\tcurl -s \"http://localhost:8080/search/?query=bad\" | python -m json.tool\n"
printf "\tcurl -s \"http://localhost:8080/document/v1/music/music/docid/2\" | python -m json.tool\n"

echo "[.] When you are finished cleanup with:"
printf "\tdocker-compose stop vespa && docker-compose rm vespa"
