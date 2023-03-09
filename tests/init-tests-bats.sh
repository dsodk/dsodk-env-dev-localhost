#!/bin/bash
### --------------------------------------------------------------------
###   init-tests-bats.sh | © 2020 Medavie
### --------------------------------------------------------------------
###   Adds the required bats framework components to the ```tests``` dir
###   of a given code project.
### --------------------------------------------------------------------
###   This code is for the use of "© 2020 Medavie" only.
###   Individuals using this code without authority, or in violation
###   of copyright are subject to investigation. Any evidence of
###   copyright infringement will be reported to law enforcement officials.
### --------------------------------------------------------------------
###   Syntax: ./init-tests-bats.sh (must be run in dir where tests dir wants to be created/setup)
### --------------------------------------------------------------------

tests_dir="../tests"

check_status()
{
    status=$? ; if [[ ${status} != 0 ]]; then echo "command failed" ; exit 1 ; fi
}


init_tests_bats()
{
  if [[ -f ${tests_dir}/lib/bin/bats ]] && [[ -f ${tests_dir}/lib/libexec/bats ]]; then
    ### bats is already setup in ${tests_dir}/lib - abort.
    echo "WARNING: The bats framework appears to already exist in ${tests_dir}/lib - aborting !"
    echo "WARNING: If you wish to refresh bats with latest, delete '${tests_dir}/lib' and re-run this script"
    exit 1
  else
    ### bats is not setup in ${tests_dir}/lib - lets set it up.
    ### Initialize tests dirs
    mkdir -p ${tests_dir}/
    mkdir -p ${tests_dir}/lib
    mkdir -p ${tests_dir}/tmp
    ### Get bats from github and extract it into a tmp dir
    wget -q -O ${tests_dir}/tmp/bats-master.zip https://github.com/sstephenson/bats/archive/master.zip ; check_status
    cd ${tests_dir}/tmp || exit 1
    unzip -q bats-master.zip ; check_status
    cd - || exit 1
    ### Copy bats files into ${tests_dir}/lib dir
    cp -R ${tests_dir}/tmp/bats-master/bin ${tests_dir}/lib/ ; check_status
    cp -R ${tests_dir}/tmp/bats-master/libexec ${tests_dir}/lib/ ; check_status
    cp ${tests_dir}/tmp/bats-master/LICENSE ${tests_dir}/lib/LICENSE-BATS ; check_status
    cp ${tests_dir}/tmp/bats-master/README.md ${tests_dir}/lib/README.md ; check_status
    ### Create ${tests_dir}/test_helper.bash script
    if [[ -f ${tests_dir}/test_helper.bash ]]; then
      echo "[INFO] ----------------------------------"
      echo "[INFO] ${tests_dir}/test_helper.bash exists - leaving it alone"
    else
      echo "[INFO] ----------------------------------"
      echo "[INFO] Creating ${tests_dir}/test_helper.bash"
      cat <<- EOF > ${tests_dir}/test_helper.bash
			#!/usr/bin/env bash

			### ================================
			### example test_helper function
			### ================================

			example_test_helper_function(){
			  sudo crontab -u root -l 2>&1 | grep -c "somepattern"
			}

			EOF
    fi
    ### Cleanup tmp dir
    rm -rf ${tests_dir}/tmp ; check_status
    ### Provide status
    echo "[INFO] ----------------------------------"
    echo "[INFO] Initiated bats into ${tests_dir}/lib:"
    echo "[INFO] ----------------------------------"
    find ${tests_dir}/lib
    echo "[INFO] ----------------------------------"
    echo "[INFO] init-tests-bats SUCCESS"
    echo "[INFO] ----------------------------------"
  fi
}

################
### MAINLINE ###
################

init_tests_bats
