#!/usr/bin/env lib/bin/bats

load test_helper

@test "test_run_ansible_playbook_main_vagrant_up" {
  # Test running main ansible playbook with vagrant up
  run vagrant up --provision
  [ "$status" -eq 0 ]
}
