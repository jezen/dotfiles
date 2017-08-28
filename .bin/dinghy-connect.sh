#!/bin/bash

function dinghy-connect {
  # Make sure SSH agent is running
  ssh-add -k

  # Make sure dinghy is up and running
  dinghy create --provider virtualbox 2> /dev/null || echo "dinghy VM already created"
  dinghy up     2> /dev/null || echo "dinghy VM already running"

  # Check if SSH forwarding is already in place
  DINGHY_SSH_SOCK=$(dinghy ssh find "/tmp/ssh-*/agent.*" 2> /dev/null || echo "missing")
  if [ "$DINGHY_SSH_SOCK" = "missing" ]; then
    echo "starting SSH connection"
    # Cleanup dangling SSH connections (just in case)
    dinghy ssh 'sudo rm -rf /tmp/ssh-*'

    # Run an ssh connection:
    # - using an emulated terminal (-t)
    # - in the background (-fn)
    # - with ssh-agent forwarding (-A)
    dinghy ssh -tfnA 'while true; do sleep 1000; done'

    # Lookup the socket on the dinghy VM
    DINGHY_SSH_SOCK=$(dinghy ssh find "/tmp/ssh-*/agent.*")
  else
    echo "existing SSH connection"
  fi

  export PROXY_SSH_AUTH_SOCK=$DINGHY_SSH_SOCK
  eval "$(dinghy env)"
  echo "dinghy ready!"
}

