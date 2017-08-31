#!/bin/bash
#
# Copyright (C) 2014 Wenva <lvyexuwenfa100@126.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is furnished
# to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

set -e

spushd() {
     pushd "$1" 2>&1 > /dev/null
}

spopd() {
     popd 2>&1 > /dev/null
}

info() {
     local green="\033[1;32m"
     local normal="\033[0m"
     echo -e "[${green}INFO${normal}] $1"
}

error() {
     local red="\033[1;31m"
     local normal="\033[0m"
     echo -e "[${red}ERROR${normal}] $1"
}

cmdcheck() {
	command -v $1>/dev/null 2>&1 || { error >&2 "Please install command $1 first."; exit 1; }	
}

curdir() {
    if [ ${0:0:1} = '/' ] || [ ${0:0:1} = '~' ]; then
        echo "$(dirname $0)"
    elif [ -L $0 ];then
        name=`readlink $0`
        echo $(dirname $name)
    else
        echo "`pwd`/$(dirname $0)"
    fi
}

usage() {
cat << EOF

USAGE: $0 [-h]

DESCRIPTION:

OPTIONS:
    -h                Show this help message and exit

EOF
}

while getopts 'h' arg; do
    case $arg in
        h)
            usage
            exit;;
        ?)
            usage
            exit;;
    esac
done

shift $(($OPTIND - 1))

spushd `curdir`

EXE=`/bin/ls -l|sed '1d'|sed '/install.sh/d'|sed '/^d/d'|awk '{print $NF}'|xargs grep -l "EXECUTE-FILE"|sed '2,$d'`
PKG="$EXE-cli"
INSTALL_DIR="/usr/local/${PKG}"

preinstall() {
	cmdcheck qrsctl
}

install(){
    [ ! -d "${INSTALL_DIR}" ] && mkdir -p ${INSTALL_DIR}
    rm -rf ${INSTALL_DIR}/*
    cp -rf * ${INSTALL_DIR}
    chmod -R 755 ${INSTALL_DIR}/commands 2>/dev/null
    chmod 755 ${INSTALL_DIR}/$EXE 2>/dev/null
    sudo ln -sf ${INSTALL_DIR}/$EXE /usr/local/bin/$EXE
}

postinstall() {
    if [ -f "${INSTALL_DIR}/$EXE" ]; then
        echo ""
        echo "Done!"
    else
        echo >&2 ""
        echo >&2 "Something went wrong. ${INSTALL_DIR}/$EXE not found"
        echo >&2 ""
        exit 1
    fi
}

preinstall
install
postinstall

spopd
