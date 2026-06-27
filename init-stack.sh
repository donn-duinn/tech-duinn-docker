#!/bin/bash
# init-stack.sh — Post-start configuration for the Tech Duinn Docker Stack
# Run after: docker compose up -d
set -e

echo "=== Tech Duinn Stack Init ==="

# Wait for SearXNG
echo "[1/2] Waiting for SearXNG..."
until curl -s -o /dev/null http://localhost:8080/config; do sleep 2; done
echo "  SearXNG is up"

# Fix formats (add json, csv, rss to allowed output formats)
echo "[2/2] Patching SearXNG formats..."
docker exec searxng sh -c '
LINE=$(grep -n "    - html" /etc/searxng/settings.yml | head -1 | cut -d: -f1)
sed -i "${LINE}a\\    - json\n    - csv\n    - rss" /etc/searxng/settings.yml
'
docker restart searxng >/dev/null
sleep 5

echo ""
echo "=== Stack Ready ==="
echo "  postgres    :5432"
echo "  redis       :6379"
echo "  searxng     :8080"
echo "  vaultwarden :8091"
echo ""
echo "Vaultwarden admin: http://localhost:8091/admin"
