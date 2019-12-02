#!/bin/bash

case "$1" in
  login)
    echo -n "Username: "
    read USER
    echo -n "Password: "
    read -s PASS
    echo -n "Bathroom thermostat ID: "
    read THERM_BR
    echo -n "Master bedroom thermostat ID: "
    read THERM_MB
    echo -n "Second bedroom thermostat ID: "
    read THERM_SB
    echo -n "Livingroom thermostat ID: "
    read THERM_LR
    mkdir -p ~/.enzoldhazam
    echo ${USER} > ~/.enzoldhazam/user
    echo ${PASS} > ~/.enzoldhazam/pass
    echo ${THERM_BR} > ~/.enzoldhazam/therm_br
    echo ${THERM_MB} > ~/.enzoldhazam/therm_mb
    echo ${THERM_SB} > ~/.enzoldhazam/therm_sb
    echo ${THERM_LR} > ~/.enzoldhazam/therm_lr
    echo
    ;;
  addtemp)
    echo -n "Bathroom temperature: "
    read TEMP_BR
    echo -n "Master bedroom temperature: "
    read TEMP_MB
    echo -n "Second bedroom temperature: "
    read TEMP_SB
    echo -n "Living room temperature: "
    read TEMP_LR
    echo ${TEMP_BR} > ~/.enzoldhazam/temp_br
    echo ${TEMP_MB} > ~/.enzoldhazam/temp_mb
    echo ${TEMP_SB} > ~/.enzoldhazam/temp_sb
    echo ${TEMP_LR} > ~/.enzoldhazam/temp_lr
    echo
    ;;
  logout)
    rm -rf ~/.enzoldhazam
    ;;
  settemp)
    USER=`cat ~/.enzoldhazam/user`
    PASS=`cat ~/.enzoldhazam/pass`
    THERM_BR=`cat ~/.enzoldhazam/therm_br`
    TEMP_BR=`cat ~/.enzoldhazam/temp_br`
    THERM_MB=`cat ~/.enzoldhazam/therm_mb`
    TEMP_MB=`cat ~/.enzoldhazam/temp_mb`
    THERM_SB=`cat ~/.enzoldhazam/therm_sb`
    TEMP_SB=`cat ~/.enzoldhazam/temp_sb`
    THERM_LR=`cat ~/.enzoldhazam/therm_lr`
    TEMP_LR=`cat ~/.enzoldhazam/temp_lr`
    COOKIE=`curl -v -X POST -F 'lang=2' -F "username=${USER}" -F "password=${PASS}" https://www.enzoldhazam.hu/login 2>&1 | grep Set-Cookie | cut -d';' -f1 | cut -d' ' -f3`
    curl -X POST -F "h=${THERM_BR}" -F 'save=1' -F "robj[${THERM_BR}]=${TEMP_BR}" --cookie "${COOKIE}" https://www.enzoldhazam.hu/ajax/thermostats >/dev/null 2>&1
    curl -X POST -F "h=${THERM_MB}" -F 'save=1' -F "robj[${THERM_MB}]=${TEMP_MB}" --cookie "${COOKIE}" https://www.enzoldhazam.hu/ajax/thermostats >/dev/null 2>&1
    curl -X POST -F "h=${THERM_SB}" -F 'save=1' -F "robj[${THERM_SB}]=${TEMP_SB}" --cookie "${COOKIE}" https://www.enzoldhazam.hu/ajax/thermostats >/dev/null 2>&1
    curl -X POST -F "h=${THERM_LR}" -F 'save=1' -F "robj[${THERM_LR}]=${TEMP_LR}" --cookie "${COOKIE}" https://www.enzoldhazam.hu/ajax/thermostats >/dev/null 2>&1
    
    ;;
  *)
    echo "Usage:  $0 {login|settemp|logout}"
    echo "This CLI tool has been written by Tibor Ölvedi <teebeey@gmail.com>"
    exit 1
    ;;
esac
