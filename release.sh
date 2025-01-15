#!/bin/sh

set_version() {
    DIR=$1
    VER=$2

    sed -i -re "s|^(version):.+|\1: ${VER}|" ${DIR}/config.yaml
    sed -i -re "s|^  amd64: \"(ghcr.io/chrivers/bifrost):.+\"|  amd64: \"\1:${VER}\"|" ${DIR}/build.yaml
}

set_version bifrost  master-2025-01-15
set_version bifrost-dev dev-2025-01-15
