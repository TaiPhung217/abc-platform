#!/usr/bin/env bash
echo "=== FORK-PAYLOAD-MARKER: guard was bypassed ==="
echo "HEAD=$(git rev-parse HEAD)"
echo "pwd=$(pwd)"
# second commit to trigger synchronize
