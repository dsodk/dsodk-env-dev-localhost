#!/usr/bin/env bash

##########################################################################
# Reference : https://github.com/mrlesmithjr/dotfiles/blob/master/setup.sh
##########################################################################

echo ""

################################
# BOOTSTRAP BASED ON OS_TYPE
################################

if [[ $(uname) == "Darwin" ]]; then
  ################################
  # BOOTSTRAP MACOS (Darwin)
  ################################
  echo "#---------------------------------"
	echo "# Detected OS_TYPE as MacOS (Darwin)"
	echo "#---------------------------------" ; echo "" ; sleep 3
  #################################
  # Init XCode Command Line Tools
  #################################
	if ! xcode-select --print-path &>/dev/null; then
	  echo "#---------------------------------"
	  echo "# MacOS: Installing Xcode Command Line Tools in NONINTERACTIVE mode"
	  echo "#---------------------------------" ; echo "" ; sleep 3
		#sudo xcode-select --install &>/dev/null
		#TODO: Test this on fresh MacBook
    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
    XCODE_COMMAND_LINE_TOOLS=$(softwareupdate -l | grep "\*.*Command Line" | head -n 1 | awk -F"*" '{print $2}' | sed -e 's/^ *//' | tr -d '\n')
    softwareupdate -i "$XCODE_COMMAND_LINE_TOOLS" --verbose
    rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
  else
    echo "#---------------------------------"
	  echo "# MacOS: Xcode Command Line Tools already installed"
	  echo "#---------------------------------" ; echo ""
	fi
	#################################
	# Init Homebrew
	#################################
	set +e
	command -v brew >/dev/null 2>&1
	BREW_CHECK=$?
	if [ $BREW_CHECK -eq 0 ]; then
    echo "#---------------------------------"
	  echo "# MacOS: Homebrew already installed"
	  echo "#---------------------------------" ; echo ""
	else
	  echo "#---------------------------------"
	  echo "# MacOS: Installing Homebrew"
	  echo "#---------------------------------" ; echo "" ; sleep 3
		NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi
	#################################
	# Init Ansible
	#################################
	command -v ansible >/dev/null 2>&1
	ANSIBLE_CHECK=$?
	if [ $ANSIBLE_CHECK -eq 0 ]; then
    echo "#---------------------------------"
	  echo "# MacOS: Ansible already installed"
	  echo "#---------------------------------" ; echo ""
	else
	  echo "#---------------------------------"
	  echo "# MacOS: Installing Ansible"
	  echo "#---------------------------------" ; echo "" ; sleep 3
		NONINTERACTIVE=1 brew install ansible
	fi
else
  ################################
  # BOOTSTRAP UNKNOWN OS_TYPE
  ################################
    echo "#---------------------------------"
	  echo "# This script was not able to determine your OS_TYPE - Are you perhaps on a OS that this project does not yet support? - ABORTING"
	  echo "#---------------------------------" ; echo ""
	  exit 1
fi
echo "#---------------------------------"
echo "# INSTALL: BOOTSTRAP PHASE COMPLETED"
echo "#---------------------------------" ; echo ""

#################################
# END
#################################
