#!/bin/sh -l
SERVER_IP=$1
SERVER_PORT=$2
RCON_PASSWORD=$3
RESOURCES_FOLDER=$4

git config --global --add safe.directory /github/workspace

if [ ${GITHUB_BASE_REF} ]; then
    # Pull Request
    git fetch origin ${GITHUB_BASE_REF} --depth=1
    export DIFF=$(git diff --name-only origin/${GITHUB_BASE_REF} ${GITHUB_SHA})
    echo "Diff between origin/${GITHUB_BASE_REF} and ${GITHUB_SHA}"
else
    # Push
    git fetch origin ${GITHUB_EVENT_BEFORE} --depth=1
    export DIFF=$(git diff --name-status ${GITHUB_EVENT_BEFORE} ${GITHUB_SHA})
    echo "Diff between ${GITHUB_EVENT_BEFORE} and ${GITHUB_SHA}"
fi

echo "Done!"