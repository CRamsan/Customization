# Define a timestamp function
timestamp() {
  date +"%Y-%m-%d_%H-%M-%S"
}

# Provide the target file path and the link path as arguments.
# If the link already exists then back it up. Then create a symbolic
# link to the target file.
function back_up_and_link {
  if [ -z "$1" ] || [ -s "$2" ];  then
    echo "${FUNCNAME[ 0 ]} needs two parameters: [TARGET] [LINK NAME]"
    return -1;
  fi
  
  TARGET=$1
  LINK_NAME=$2  
  if [ -e "$TARGET" ]; then
    back_up_file $TARGET
  fi
  ln -s $TARGET $LINK_NAME
}

# Provide a file to backup. This function will create a copy of the file
# with a timestamp appended to it.
function back_up_file {
  if [ -z "$1" ];  then
    echo "${FUNCNAME[ 0 ]} needs a parameter: [FILE NAME]"
    return -1;
  fi
  
  FILE=$1
  BACKUP="$FILE-timestamp"
  echo "Moving $FILE to $BACKUP"
  mv $FILE $BACKUP
}

# Provide a platform config as an argument. This method will use the
# parameter to find the folder containing all the platform scripts and
# it will run them in order. Then the same will be done for scripts that
# are platform independent. 
function run_plat_config {
  if [ -z "$1" ];  then
    echo "${FUNCNAME[ 0 ]} needs a parameter: [$PLAT_CONFIG_LINUX]"
    return -1;
  fi

  SCRIPTS_FOLDER="$CONFIG_FOLDER/$1/"
  if [ ! -e "$SCRIPTS_FOLDER" ]; then
    echo "Scripts folder $SCRIPTS_FOLDER does not exist, stopping deployment"
    return -3;
  fi

  SCRIPTS_FOLDER="$CONFIG_FOLDER/$CONFIG_FOLDER_COMMON"
  if [ ! -e "$SCRIPTS_FOLDER" ]; then
    echo "Scripts folder $SCRIPTS_FOLDER does not exist, stopping deployment"
    return -3;
  fi
  
  echo "Starting to run platform scripts for $1"
  PLAT_SCRIPT="$CONFIG_FOLDER/$1$SCRIPT_EXT"
  if validate_script $PLAT_SCRIPT; then
    . $PLAT_SCRIPT
  else
    echo "Error with $PLAT_SCRIPT, does not match criteria for runnable script"
  fi
  echo "Completed running platform scripts for $1"
}

# This function will take a directory as a parameter.
# All the scripts inside the folder will be run in order.
# If any script fails, execution will stop.
function run_all_scripts {
  if [ -z "$1" ];  then
    echo "${FUNCNAME[ 0 ]} needs a folder path"
    return -1;
  fi

  SCRIPT_FOLDER=$1
  if [ ! -d "$SCRIPT_FOLDER" ]; then
    echo "Script folder $SCRIPT_FOLDER does not exist"
    return 2
  fi 
  SCRIPT_FOLDER_REGEX="$SCRIPT_FOLDER/*" 
  echo "About to run all scripts found with $SCRIPT_FOLDER_REGEX"
  for SCRIPT in $SCRIPT_FOLDER_REGEX; do
    if [ "$SCRIPT" == "$SCRIPT_FOLDER_REGEX" ]; then
      echo $SCRIPT
      echo $SCRIPT_FOLDER_REGEX
      continue
    fi
    if validate_script $SCRIPT; then
      echo "Running script $SCRIPT"
      . $SCRIPT
    else
      echo "Ignoring $SCRIPT"
    fi
  done
}

# Pass the path for a script that will be check to be valid 
# to be run by this script. This method will check this conditions
# in order:
# 1) File exists
# 2) File is a regular file and not a block device, symlink, etc
# 3) File is executable
# 4) File name ends in the value of SCRIPT_EXT, usuallt .sh
function validate_script {
  if [ -z "$1" ]; then
    echo "${FUNCNAME[ 0 ]} needs a file to test"
  fi

  SCRIPT=$1
  if [ ! -e $SCRIPT ]; then
    echo "File $SCRIPT does not exist"
    return 1;
  fi
  if [ ! -f $SCRIPT ]; then
    echo "File $SCRIPT is not regular file"
    return 2;
  fi
  if [ ! -x $SCRIPT ]; then
    echo "File $SCRIPT is not executable"
    return 3;
  fi
  if [[ ! $SCRIPT == *$SCRIPT_EXT ]]; then
    echo "File $SCRIPT does not end with $SCRIPT_EXT"
    return 4;
  fi

  return 0;
}

# Create a folder that represents a key.
# If a key can be created then return 0. 
# Return non zero values otherwise. This
# method can be used to store bool values.
function create_key {
  create_registry
  if [ -z "$1" ]; then
    echo "Key name was not provided"
    return -1
  fi

  if mkdir "$USER_REG/$1"; then
    echo "Created key for $1"
    return 0
  else
    echo "Key $1 could not be created"
    return 1
  fi
}

# Make the folder tree all the way to USER_REG
# This folder will be used to store folders that 
# will work like mutexes 
function create_registry {
  mkdir -p $USER_REG
}

export -f timestamp
export -f back_up_and_link
export -f back_up_file
export -f run_plat_config
export -f run_all_scripts
export -f create_key

export CONFIG_FOLDER="configs"
export PLAT_NAME_LINUX="Linux"
export PLAT_CONFIG_LINUX="linux"
export CONFIG_FOLDER_COMMON="common"
export SCRIPT_EXT=".sh"
export USER_REG=~/.config/cramsan
