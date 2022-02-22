#!/usr/bin/env bash
BGreen='\033[1;32m'
BYellow='\033[1;33m'
BCyan='\033[1;36m'
BPurple='\033[1;35m'
Reset_all='\033[0m'
WORKING_DIR=$(pwd)

function install_nanomsg() {
    echo -e "${BCyan}Cloning into nanomsg${Reset_all}"
    set -x
    git clone https://github.com/nanomsg/nanomsg.git nanomsg
    cd nanomsg
    mkdir build
    cd build
    set +x

    echo -e "${BYellow}Building nanomsg${Reset_all}"
    set -x
    cmake ..
    cmake --build .
    ctest .
    set +x

    echo -e "${BYellow}Cmake-Install nanomsg${Reset_all}"
    set -x
    sudo cmake --build . --target install
    sudo ldconfig
    cd $WORKING_DIR
    set +x
}

function install_thrift() {
    echo -e "${BCyan}Getting thrift 0.11${Reset_all}"
    set -x
    wget https://github.com/apache/thrift/archive/refs/tags/0.11.0.tar.gz
    tar xzf 0.11.0.tar.gz
    rm 0.11.0.tar.gz
    cd thrift-0.11.0
    set +x

    echo -e "${BYellow}Configuring thrift${Reset_all}"
    set -x
    ./bootstrap.sh
    ./configure
    set +x

    echo -e "${BYellow}Making thrift${Reset_all}"
    make
    sudo make install
    cd $WORKING_DIR
}

function install_behavioral_model() {
    sudo apt-get install -y automake cmake libgmp-dev libpcap-dev libboost-dev libboost-test-dev libboost-program-options-dev libboost-system-dev libboost-filesystem-dev libboost-thread-dev libevent-dev libtool flex bison pkg-config g++ libssl-dev

    echo -e "${BPurple}Installing nanomsg${Reset_all}"
    install_nanomsg

    echo -e "${BPurple}Installing thrift${Reset_all}"
    install_thrift

    echo -e "${BPurple}Installin bmv2${Reset_all}"

    echo -e "${BCyan}Cloning into bmv2${Reset_all}"
    set -x
    git clone https://github.com/p4lang/behavioral-model.git bmv
    cd bmv
    set +x

    echo -e "${BYellow}Running autogen and configure${Reset_all}"
    set -x
    ./autogen.sh
    ./configure
    set +x

    echo -e "${BYellow}Running make and make install${Reset_all}"
    make
    sudo make install
}

function install_pip_dependencies() {
    echo -e "${BPurple}Installing pip requirements${Reset_all}"
    pip install networkx
    pip install scapy
    pip install numpy
}

sudo apt-get update
install_behavioral_model
install_pip_dependencies

