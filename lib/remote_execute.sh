#!/bin/sh
# remote_execute.sh

# usage            : remote_execute.sh <option>
# option(required) : -h <host name>
#                    -u <user name>
#                    -p <user password>
#                    -c <command>

RREMOTE_HOST=''
REMOTE_USER=''
REMOTE_PASSWD=''
REMOTE_CMD=''

FLG_REMOTE_HOST=0
FLG_REMOTE_USER=0
FLG_REMOTE_PASSWD=0
FLG_REMOTE_CMD=0

function start() {
    expect -c "
        set timeout 5
        spawn ssh ${REMOTE_USER}@${REMOTE_HOST} \". .bash_profile ; ${REMOTE_CMD}\"
        expect \"password:\"
        send \"${REMOTE_PASSWD}\n\"
        interact"
}

function initialize() {
    if [ $FLG_REMOTE_HOST -ne 1 ] ; then
        echo "error : required host name"
        exit 1
    elif [ $FLG_REMOTE_USER -ne 1 ] ; then
        echo "error : required user name"
        exit 1
    elif [ $FLG_REMOTE_PASSWD -ne 1 ] ; then
        echo "error : required user password"
        exit 1
    elif [ $FLG_REMOTE_CMD -ne 1 ] ; then
        echo "error : required command"
        exit 1
    fi
}

function main() {
    initialize
    start
}

for OPT in $* ; do
    case $OPT in
        '-h' )
            REMOTE_HOST=$2
            FLG_REMOTE_HOST=1
            shift 2
            ;;
        '-u' )
            FLG_REMOTE_USER=1
            REMOTE_USER=$2
            shift 2
            ;;
        '-p' )
            FLG_REMOTE_PASSWD=1
            REMOTE_PASSWD=$2
            shift 2
            ;;
        '-c' )
            FLG_REMOTE_CMD=1
            REMOTE_CMD=$2
            shift 2
            ;;
    esac
done

main
