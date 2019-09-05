#!/bin/bash

case "$1" in
  login)
    echo -n "Username: "
    read USER
    echo -n "Password: "
    read -s PASS
    mkdir -p ~/.enzoldhazam
    echo ${USER} > ~/.enzoldhazam/user
    echo ${PASS} > ~/.enzoldhazam/pass
    echo
    ;;
  logout)
    rm -rf ~/.enzoldhazam
    ;;
  settemp)
    USER=`cat ~/.enzoldhazam/user`
    PASS=`cat ~/.enzoldhazam/pass`
    echo -n "Thermostat ID: "
    read THERM
    echo -n "Temperature: "
    read TEMP
    COOKIE=`curl -v -X POST -F 'lang=2' -F "username=${USER}" -F "password=${PASS}" https://www.enzoldhazam.hu/login 2>&1 | grep Set-Cookie | cut -d';' -f1 | cut -d' ' -f3`
    curl -X POST -F "h=${THERM}" -F 'save=1' -F "robj[${THERM}]=${TEMP}" -F 'timer=f=&day=&fdata%5Bday-1-1-time%5D=0000&fdata%5Bday-1-1-temp%5D=25&fdata%5Bday-1-0-time%5D=0015&fdata%5Bday-1-0-temp%5D=21&fdata%5Bday-2-1-time%5D=0000&fdata%5Bday-2-1-temp%5D=25&fdata%5Bday-2-0-time%5D=0015&fdata%5Bday-2-0-temp%5D=21&fdata%5Bday-3-1-time%5D=0000&fdata%5Bday-3-1-temp%5D=25&fdata%5Bday-3-0-time%5D=0015&fdata%5Bday-3-0-temp%5D=21&fdata%5Bday-4-1-time%5D=0000&fdata%5Bday-4-1-temp%5D=25&fdata%5Bday-4-0-time%5D=0015&fdata%5Bday-4-0-temp%5D=21&fdata%5Bday-5-1-time%5D=0000&fdata%5Bday-5-1-temp%5D=25&fdata%5Bday-5-0-time%5D=0015&fdata%5Bday-5-0-temp%5D=21&fdata%5Bday-6-1-time%5D=0000&fdata%5Bday-6-1-temp%5D=25&fdata%5Bday-6-0-time%5D=0015&fdata%5Bday-6-0-temp%5D=21&fdata%5Bday-7-1-time%5D=0000&fdata%5Bday-7-1-temp%5D=25&fdata%5Bday-7-0-time%5D=0015&fdata%5Bday-7-0-temp%5D=21' --cookie "${COOKIE}" https://www.enzoldhazam.hu/ajax/thermostats >/dev/null 2>&1
    ;;
  *)
    echo "Usage:  $0 {login|settemp|logout}"
    echo "This CLI tool has been written by Tibor Ölvedi <teebeey@gmail.com>"
    exit 1
    ;;
esac

