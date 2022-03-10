#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

STEAMCMD_URL="https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz"

# 安装Steamcmd
function installSteamcmd() {
    wget -O ${STEAMCMDDIR}/steamcmd.tar.gz ${STEAMCMD_URL}
    tar zxkf ${STEAMCMDDIR}/steamcmd.tar.gz -C ${STEAMCMDDIR}
    rm ${STEAMCMDDIR}/steamcmd.tar.gz
}

# 安装CSGO
function installCSGO() {
    bash ${STEAMCMDDIR}/steamcmd.sh \
        +force_install_dir ${CSGODIR} \
        +login anonymous \
        +app_update 740 \
        +quit
}

# 主要流程
installSteamcmd
echo -e "Steamcmd安装完成"
installCSGO
echo -e "安装完成"
