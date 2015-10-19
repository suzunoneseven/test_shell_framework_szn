#!//bin/sh
# tail_manager.sh

# usage            : tail_manager.sh <command>
# command          : start <option>
#                  : stop
# option(required) : -t <target file(full path)>
#                  : -o <output file(full path)>

TAIL_TARGET_FILE=""
TAIL_OUTPUT_FILE=""
TAIL_PID_FILE="/tmp/tail_pid_file.txt"

FLG_TAIL_TARGET_FILE=0
FLG_TAIL_OUTPUT_FILE=0
# 0: start, 1: stop
FLG_MODE=1

function start() {
    echo "# -- tail start ${TAIL_TARGET_FILE}"
    [ ! -e "${TAIL_OUTPUT_FILE}" ] && mkdir -p `dirname ${TAIL_OUTPUT_FILE}`
    sudo sh -c "nohup tail -F -n0 ${TAIL_TARGET_FILE} > ${TAIL_OUTPUT_FILE} & echo \${!}" >> $TAIL_PID_FILE
}

function stop() {
    echo "# -- tail stop"
    KILL_PIDS=`cat $TAIL_PID_FILE | awk '{ print $1 }' | grep -v -e '^\s*#' -e '^\s*$'`
    if [ "${KILL_PIDS}" = "" ] ; then
        echo "pid nothing"
    else
        for KILL_PID in ${KILL_PIDS[@]} ; do
            echo "      kill PID = ${KILL_PID}"
            sudo kill -9 ${KILL_PID}
        done
        echo "" >  $TAIL_PID_FILE
    fi
}

function main() {
    if [ "$FLG_MODE" -ne 0 ] ; then
        stop
    else
        if [ "$FLG_TAIL_TARGET_FILE" -ne 1 ] ; then
            echo "error : required target file"
            exit 1
        elif [ "$FLG_TAIL_OUTPUT_FILE" -ne 1 ] ; then
            echo "error : required output file"
            exit 1
        else
            start
        fi
    fi
}

for OPT in $* ; do
    case $OPT in
        '-o' )
            TAIL_OUTPUT_FILE=$2
            FLG_TAIL_OUTPUT_FILE=1
            shift 2
            ;;
        '-t' )
            TAIL_TARGET_FILE=$2
            FLG_TAIL_TARGET_FILE=1
            shift 2
            ;;
        'stop' )
            FLG_MODE=1
            shift 1
            ;;
        'start' )
            FLG_MODE=0
            shift 1
            ;;
    esac
done

main
