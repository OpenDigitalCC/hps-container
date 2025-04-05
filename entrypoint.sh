#!/bin/bash
set -euo pipefail

RUNFILE=/srv/hps/scripts/run-hps.sh

if [[ ! -x $RUNFILE ]]; then
  echo '[ERROR] $0 Required file $RUNFILE is missing or not executable.' >&2
  echo '[ERROR] $0 It looks like the hps-system is not installed.' >&2
  echo '[ERROR] $0 Please extract hps-system into /srv/hps for this container to function.' >&2
  sleep 2
  exit 1
fi

echo "[✓] $0: hps-system mounted and run-hps.sh is present, running hps"

exec $RUNFILE

