#!/bin/bash
. utils.sh # Source the file with helper functions

PLATFORM='unknown'
PLAT=`uname`
if [ "$PLAT" == 'Linux' ]; then
  PLATFORM=$PLAT_NAME_LINUX
fi

case "$PLATFORM" in
  "$PLAT_NAME_LINUX")
    run_plat_config $PLAT_CONFIG_LINUX
    ;;
  *)
    echo "Unkown platform $PLAT, not deploying any changes"
    exit 2
esac
