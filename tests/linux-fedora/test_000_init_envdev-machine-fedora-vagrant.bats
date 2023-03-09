#!/usr/bin/env lib/bin/bats

load test_helper

#########################################################
# https://stribny.name/blog/provisioning-ansible-vagrant/
# sudo dnf install ansible vagrant VirtualBox -y
# https://app.vagrantup.com/generic/boxes/fedora34
#########################################################

@test "init_install_ansible_on_local_machine" {
  # Initialization - install ansible on local machine
  run sudo dnf install ansible -y
  [ "$status" -eq 0 ]
}

@test "init_install_vagrant_on_local_machine" {
  # Initialization - install vagrant on local machine
  run sudo dnf install vagrant -y
  [ "$status" -eq 0 ]
}

@test "init_install_virtualbox_on_local_machine" {
  # Initialization - install virtualbox on local machine
  run sudo dnf install VirtualBox -y
  [ "$status" -eq 0 ]
}

@test "init_assert_virtualization_is_enabled_in_bios" {
  # Initialization - assert that virtualization is enabled in bios
  run assert_virtualization_is_enabled_in_bios
  [ "$status" -eq 0 ]
}

@test "init_assert_kvm_kernel_module_is_loaded" {
  # Initialization - assert that KVM kernel module is loaded
  run assert_kvm_kernel_module_is_loaded
  [ "$status" -eq 0 ]
}

@test "init_install_virtualization_support_in_fedora" {
  # Initialization - install virtualization support in Fedora
  run sudo dnf install -y @virtualization
  [ "$status" -eq 0 ]
}

@test "init_start_libvirtd_virtualization_service" {
  # Initialization - Start the libvirtd virtualization service
  run sudo systemctl start libvirtd
  [ "$status" -eq 0 ]
}

@test "init_install_akmod_virtualbox_in_kernel" {
  # Initialization - install akmod-VirtualBox
  set_test_properties
  run sudo dnf install -y akmod-VirtualBox kernel-devel-$KERNEL_VERSION
  [ "$status" -eq 0 ]
}

@test "init_apply_akmod_virtualbox_in_kernel" {
  # Initialization - apply akmod-VirtualBox
  set_test_properties
  run sudo akmods --kernels $KERNEL_VERSION
  [ "$status" -eq 0 ]
}

@test "init_start_virtualbox_driver_service" {
  # Initialization - start virtualbox driver system service
  set_test_properties
  run sudo systemctl restart vboxdrv.service
  [ "$status" -eq 0 ]
}

@test "init_vagrant_target_directory" {
  # Initialization - Create target directory for vagrant home
  set_test_properties
  run mkdir -p $VAGRANT_HOME
  [ "$status" -eq 0 ]
}

@test "init_vagrant_work_directory" {
  # Initialization - Create work directory for vagrant box
  set_test_properties
  run mkdir -p $VAGRANT_CWD
  [ "$status" -eq 0 ]
}

@test "init_vagrant_box_add_generic_fedora" {
  # Initialization - Add vagrant box for generic fedora
  set_test_properties
  run vagrant box add --force --provider $VAGRANT_DEFAULT_PROVIDER $VAGRANT_BOX
  [ "$status" -eq 0 ]
}

##############################################
# To generate a VagrantFile at this stage, you can run:
# vagrant init $VAGRANT_BOX
##############################################

