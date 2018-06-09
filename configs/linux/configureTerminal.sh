#!/bin/bash

if [ -z "$HOME" ]; then
  echo "HOME variable is not set! This script relies on this variable. Please set variable and run again.";
  return
fi

local LOCAL_CWD=$(pwd)
local LOCAL_CURRENT_CONFIG_FOLDER=$LOCAL_CWD/$CONFIG_FOLDER/$PLAT_CONFIG_LINUX
set -x
ln -s $LOCAL_CURRENT_CONFIG_FOLDER/inputrc $HOME/.inputrc
ln -s $LOCAL_CURRENT_CONFIG_FOLDER/vimrc $HOME/.vimrc
ln -s $LOCAL_CURRENT_CONFIG_FOLDER/bashrc $HOME/.bashrc
ln -s $LOCAL_CURRENT_CONFIG_FOLDER/bash_profile $HOME/.bash_profile
set +x
cp -n $LOCAL_CURRENT_CONFIG_FOLDER/bashrc_override $HOME/.bashrc_override
cp -n $LOCAL_CURRENT_CONFIG_FOLDER/bash_profile_override $HOME/.bash_profile_override
