#!/usr/bin/env bash
set -euo pipefail

SSH_USER="root"

declare -A HOSTS=(
  ["patrick"]="192.168.2.100"
  ["spongebob"]="192.168.2.101"
  ["larry"]="192.168.2.42"
)

for HOSTNAME in "${!HOSTS[@]}"; do
  IP="${HOSTS[$HOSTNAME]}"

  echo "========================================"
  echo "Deploying ${HOSTNAME} to ${IP}"
  echo "========================================"

  nixos-rebuild switch \
    --flake ".#${HOSTNAME}" \
    --target-host "${SSH_USER}@${IP}" \
    --build-host "${SSH_USER}@${IP}" \
    --fast

  echo "${HOSTNAME} deployment complete"
  echo
done

echo "All deployments finished successfully"
