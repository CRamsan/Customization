#!/bin/bash

local LOCAL_CWD=$(pwd)
local LOCAL_CURRENT_CONFIG_FOLDER=$LOCAL_CWD/$CONFIG_FOLDER/$PLAT_CONFIG_LINUX/
ln -s $LOCAL_CURRENT_CONFIG_FOLDER/inputrc ~/.inputrc
ln -s $LOCAL_CURRENT_CONFIG_FOLDER/vimrc ~/.vimrc
ln -s $LOCAL_CURRENT_CONFIG_FOLDER/bashrc ~/.bashrc
ln -s $LOCAL_CURRENT_CONFIG_FOLDER/bash_profile ~/.bash_profile
