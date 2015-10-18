#!/bin/sh
# logget.sh

# usage            : logget.sh <option>
# option(required) : -h <host name>
#                    -u <user name>
#                    -p <user password>
#                    -f <terget file (full path)>

RREMOTE_HOST=''
REMOTE_USER=''
REMOTE_PASSWD=''
REMOTE_TAIL_FILE=''

FLG_REMOTE_HOST=0
FLG_REMOTE_USER=0
FLG_REMOTE_PASSWD=0
FLG_REMOTE_TAIL_FILE=0

function start() {
    ./remote_execute.sh -h $REMOTE_HOST -u $REMOTE_USER -p $REMOTE_PASSWD -c "tail -Fn0 ${REMOTE_TAIL_FILE}"
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
    elif [ $FLG_REMOTE_TAIL_FILE -ne 1 ] ; then
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
        '-f' )
            FLG_REMOTE_TAIL_FILE=1
            REMOTE_TAIL_FILE=$2
            shift 2
            ;;
    esac
done

main
