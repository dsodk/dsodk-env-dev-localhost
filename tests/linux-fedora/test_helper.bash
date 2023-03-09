#!/usr/bin/env bash

### ================================
### example test_helper function
### ================================

set_test_properties(){
  source test_helper.properties
  KERNEL_VERSION=$(uname -r)
}

example_test_helper_function(){
  sudo crontab -u root -l 2>&1 | grep -c "somepattern"
}

assert_virtualization_is_enabled_in_bios(){
  result=$(cat /proc/cpuinfo | egrep -c "vmx|svm")
  if [[ $result == 0 ]];then
    exit 1
  fi
}

assert_kvm_kernel_module_is_loaded(){
  result=$(lsmod | grep -c "kvm")
  if [[ $result == 0 ]];then
    exit 1
  fi
}


