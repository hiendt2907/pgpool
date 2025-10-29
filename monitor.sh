#!/usr/bin/env bash
# Monitor pgpool-II health and backend status (minimal logging)

PREV_BACKEND_STATUS=""

while true; do
    sleep 60
    
    # Check pgpool process
    if ! pgrep -x pgpool > /dev/null; then
        echo "[$(date -Iseconds)] [CRITICAL] ⚠️  pgpool process not running!"
        exit 1
    fi
    
    # Check backend status - only log if changed
    CURRENT_BACKEND_STATUS=$(pcp_node_info -h localhost -p 9898 -U admin -w 2>/dev/null | grep -E "status|role" || echo "")
    
    if [ "$CURRENT_BACKEND_STATUS" != "$PREV_BACKEND_STATUS" ]; then
        echo "[$(date -Iseconds)] [INFO] ⚠️  Backend status changed:"
        pcp_node_info -h localhost -p 9898 -U admin -w 2>/dev/null || echo "Unable to fetch backend info"
        PREV_BACKEND_STATUS="$CURRENT_BACKEND_STATUS"
    fi
done
