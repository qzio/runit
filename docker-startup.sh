#!/usr/bin/env bash
#
# This script may be used in a docker container together with --init as an alternative to runit-init.
# When using runit-init, runit will be pid 1 and will listen for SIGCONT to move forward in runits' stages.
# However, even if you comply with runit's requirements for shutdown,
# the docker container will not stop when "kill -18 1" or "docker stop ..." is run.
# It will run the shutdown procedure fine etc but will not actually stop the container.
# The above has been tested with docker-ce 17.06
#
# run_nextstage will run a runit stage in /etc/runit/{1,2,3} using a blocking sub shell.
#
set -eu

# Keep the stage in a global variable
INIT_STAGE=1

trap run_nextstage CONT

run_nextstage()
{
  # Current_stage is the one to run.
  local current_stage=${INIT_STAGE}
  # Ensure the next stage is run the next time run_nextstage is called.
  INIT_STAGE=$(( INIT_STAGE + 1 ))
  [ -x /etc/runit/${current_stage} ] && echo $(/etc/runit/${current_stage})
  # Shutdown if stage 3 was run
  if [ $current_stage -gt 2 ] ; then
    echo "stage is bigger than 2 (${current_stage}) and is done ; exiting"
    exit 0
  fi
}

# 1 is expected to run and exit 0
run_nextstage
# 2
run_nextstage
# 3 will be triggered automatically if SIGCONT is sent to this script
