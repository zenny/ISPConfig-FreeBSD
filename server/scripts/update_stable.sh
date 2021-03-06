#!/bin/bash

_UPD=1

# padding handles script being overwritten during updates
# see https://git.ispconfig.org/ispconfig/ispconfig3/issues/4227

##################################################
##################################################
##################################################
##################################################
##################################################
##################################################
##################################################
##################################################
##################################################
##################################################
##################################################
##################################################

{
if [ -n "${_UPD}" ]
then
    {
        umask 0077 \
        && tmpdir=`mktemp -dt "$(basename $0).XXXXXXXXXX"` \
        && test -d "${tmpdir}" \
        && cd "${tmpdir}"
    } || {
        echo 'mktemp failed'
        exit 1
    }

    wget https://freeshells.org/downloads/ISPConfig-BSD.tar.gz
    if [ -f ISPConfig-BSD.tar.gz ]
    then
        tar xvfz ISPConfig-BSD.tar.gz
        cd ispconfig3_install/install/
        php -q \
            -d disable_classes= \
            -d disable_functions= \
            -d open_basedir= \
            update.php
        cd /tmp
        rm -rf "${tmpdir}"
    else
        echo "Unable to download the update."
        exit 1
    fi

fi

exit 0
}
