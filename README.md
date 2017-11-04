# Vespa Runner

This configures the basic sample detailed here: http://docs.vespa.ai/documentation/vespa-quick-start.html

# Required Tools

- [Docker for Desktop](https://www.docker.com/community-edition#/download) ([mirror](https://www.docker.com/get-docker))
- [Python](https://www.python.org/downloads/)

# How To Run

```bash
git clone --recurse-submodules git@github.com-nbcsteveb:nbcsteveb/vespa.sh.git vespa;
cd vespa;
./vespa.sh
```

You should see following output:

```
[.] Starting Vespa Container..
Creating vespa_vespa_1 ...
Creating vespa_vespa_1 ... done
[.] Server is running!
[.] Deploying sample app..
Uploading application '/vespa-sample-apps/basic-search/src/main/application/' using http://localhost:19071/application/v2/tenant/default/session?name=application
Session 2 for tenant 'default' created.
Preparing session 2 using http://localhost:19071/application/v2/tenant/default/session/2/prepared
Session 2 for tenant 'default' prepared.
Activating session 2 using http://localhost:19071/application/v2/tenant/default/session/2/active
Session 2 for tenant 'default' activated.
Checksum:   04a45f7e81f9c201bbca190889d9217e
Timestamp:  1509820281371
Generation: 2
[.] Sample app is running!
[.] Feeding documents..
{
    "id": "id:music:music::1",
    "pathId": "/document/v1/music/music/docid/1"
}
{
    "id": "id:music:music::2",
    "pathId": "/document/v1/music/music/docid/2"
}
[.] Ready! Try some commands:
    curl -s "http://localhost:8080/search/?query=bad" | python -m json.tool
    curl -s "http://localhost:8080/document/v1/music/music/docid/2" | python -m json.tool
[.] When you are finished cleanup with:
    docker-compose stop vespa && docker-compose rm vespa
```