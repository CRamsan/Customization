#!/bin/bash
. utils.sh # Source the file with helper functions
L_PLATFORM='unknown'
L_PLAT=`uname`
if [ "$L_PLAT" == 'Linux' ] || [ "$L_PLAT" == 'MINGW64_NT-10.0' ]; then
  L_PLATFORM=$PLAT_NAME_LINUX
fi
case "$L_PLATFORM" in
  "$PLAT_NAME_LINUX")
    run_plat_config $PLAT_CONFIG_LINUX
    ;;
  *)
    echo "Unkown platform $L_PLAT, not deploying any changes"
    exit 2
esac
