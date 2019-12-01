#!/usr/bin/env bats

@test "example 1" {
  run ./fuel.sh 14
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "2" ]
}

@test "example 2" {
  run ./fuel.sh 1969
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "966" ]
}

@test "example 3" {
  run ./fuel.sh 100756
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "50346" ]
}
