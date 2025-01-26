#!/bin/sh

set_version() {
    DIR=$1
    VER=$2

    sed -i -re "s|^(version):.+|\1: ${VER}|" ${DIR}/config.yaml
    sed -i -re "s|^  (.+): \"(ghcr.io/chrivers/bifrost):.+\"|  \1: \"\2:${VER}\"|" ${DIR}/build.yaml
}

set_version bifrost  master-2025-01-26
set_version bifrost-dev dev-2025-01-26
