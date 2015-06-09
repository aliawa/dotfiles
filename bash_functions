#!/bin/bash

function target_arch() {
    case "$PLATFORM_TYPE" in
    E200|E250|E300)
        TARGET_ARCH=mips
        ;;
    E5300|E5300LF|E5300LF2|E6400|E6400LF|E6400LF2|E6400LF2V6|EMVOSS|E7000)
        TARGET_ARCH=pentium4
        ;;
    E4200|E4300|E4500)
        TARGET_ARCH=arm
        ;;
    E4600)
        TARGET_ARCH=powerpc
        ;;
    E4700)
        TARGET_ARCH=powerpc
        ;;
    E4800)
        TARGET_ARCH=powerpc
        ;;
    E460X)
        TARGET_ARCH=powerpc
        PLATFORM_TYPE=E4600
        ;;
    E457X)
        TARGET_ARCH=powerpc
        ;;
    *)
        TARGET_ARCH=unknown
        ;;
    esac
}

function ewarch() {
    if [ "$#" -eq 3 ]; then
        # support legacy aliases
        echo "sX$HOME/XX" > sed.tmp
        DEVDIR=`echo $1| sed -f sed.tmp`
        rm -f sed.tmp
        DEVROOT=$HOME/$DEVDIR
        source $DEVROOT/e30/build/setarch $2 $3 $DEVROOT/snapgear $DEVROOT/e30
    elif [ "$#" -eq 2 ]; then
        PLATFORM_TYPE=$2
        target_arch 
        DEVROOT=$1
        source $DEVROOT/e30/build/setarch $TARGET_ARCH $2 $DEVROOT/snapgear $DEVROOT/e30
    elif [ "$#" -eq 1 ]; then
        echo "sX$HOME/XX" > sed.tmp
        DEVDIR=`echo $PWD| sed -f sed.tmp`
        rm -f sed.tmp
        DEVROOT=$HOME/$DEVDIR
        PLATFORM_TYPE=$1
        target_arch 
        source $DEVROOT/e30/build/setarch $TARGET_ARCH $1 $DEVROOT/snapgear $DEVROOT/e30
    else
        echo "e.g. $0 E4500"
        echo "e.g. $0 $HOME/4500 E4500"
        echo "e.g. $0 $HOME/4500 arm E4500"
    fi
}




function sharch() {
	echo
	echo "  ENARCH          = $ENARCH"
	echo "  ENTARGET        = $ENTARGET"
	echo "  OSTOP           = $OSTOP"
	echo "  PTOP            = $PTOP"
	echo "  CROSS_HOST      = $CROSS_HOST"
	echo "  CROSS_FLAGS     = $CROSS_FLAGS"
	echo "  HOST_DEBUG      = $HOST_DEBUG"
	echo "  EXTRA_DEFINES   = $EXTRA_DEFINES"
	echo "  DEV_VER         = $DEV_VER"
	echo "  EWN_ONLY_BUILD  = $EWN_ONLY_BUILD"
	echo "  CONFIG_LINUXDIR = $CONFIG_LINUXDIR"
	echo "  CONFIG_LIBCDIR  = $CONFIG_LIBCDIR"
    echo "  CSCOPE_DB       = $CSCOPE_DB"
	echo
}





function dir2Platform() {
    if [ "$1" == "host" ]; then
        echo "E7000"
    else
        echo E$(echo $1 | tr '[:lower:]' '[:upper:]')
    fi
}


setbuildenv() {
    #source ~/bin/e30_build/bash_functions
    savedpwd=$PWD

    # Try to obtain platform type from directory name
    while true
    do
        DIRNAME=`basename $PWD`
        if [[ "$DIRNAME" == "project" || "$DIRNAME" == "home"  || "$PWD" == "/" ]]; then
            echo "Not a platform directory"
            cd $savedpwd
            return 1;
        fi
        PREFIX=${DIRNAME%%_*}
        TARGET_TYPE=`dir2Platform $PREFIX`
        PLATFORM_TYPE=$TARGET_TYPE
        target_arch  #sets TARGET_ARCH and PLATFORM_TYPE
        if [ "$TARGET_ARCH" == "unknown" ]; then
             echo "Unknown PLATFORM_TYPE: $PLATFORM_TYPE"
             cd .. #check parent directory
        else
             break
        fi
    done


    # create fake directories to satisfy setarch script
    fakesnapgear="false"
    fakee30="false"
    [ -d snapgear ] || { mkdir snapgear; fakesnapgear="true"; }
    [ -d e30      ] || { mkdir e30;      fakee30="true"; }

    source ~/bin/e30_build/setarch $TARGET_ARCH $TARGET_TYPE $PWD/snapgear $PWD/e30


    # remove fake directories
    [ "$fakesnapgear" == "true" ] && rmdir snapgear
    [ "$fakee30" == "true" ] && rmdir e30


    # extra env varibales
    if [ "$PREFIX" == "host" ]; then
        export HOST_DEBUG=1
        echo -n "  "
        echo -e "\033[1mHOST_DEBUG=$HOST_DEBUG\033[0m"
        echo
    else
        unset HOST_DEBUG
    fi
    [ -f $OSTOP/.config ] && export $(grep CONFIG_LINUXDIR $OSTOP/.config)
    [ -f $OSTOP/.config ] && export $(grep CONFIG_LIBCDIR $OSTOP/.config)
    unset EXTRA_DEFINES
    unset CONFIG_LIB_SOFT_DSP

    # Restore PWD
    cd $savedpwd
}


# Replay
replay_set() {
    if [ "${ENTARGET:1:4}" != "7000" ]; then
        echo "cannot use $ENTARGET for replay"
        echo
        return
    fi
    export HOST_DEBUG=1
    export EXTRA_DEFINES=-DEWN_REPLAY
    cd $PTOP && make -C libewn clean all && make -C mand clean all 
    cd -
}


replay_unset() {
    if [ "${ENTARGET:1:4}" != "7000" ]; then
        echo "cannot use $ENTARGET for replay"
        echo
        return
    fi
    export HOST_DEBUG=1
    unset EXTRA_DEFINES
    cd $PTOP && make -C libewn clean all && make -C mand clean all
    cd -
}
