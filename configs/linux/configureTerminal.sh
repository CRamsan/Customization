#!/bin/bash

local CWD=$(pwd)
local CURRENT_CONFIG_FOLDER=$CWD/$CONFIG_FOLDER/$PLAT_CONFIG_LINUX/
ln -s $CURRENT_CONFIG_FOLDER/inputrc ~/.inputrc
ln -s $CURRENC_CONFIG_FOLDER/vimrc ~/.vimrc

