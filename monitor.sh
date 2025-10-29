#!/usr/bin/env bash
# Monitor pgpool-II health and backend status (minimal logging)

PREV_BACKEND_STATUS=""

while true; do
    sleep 60
    
    # Check pgpool process
    if ! pgrep -x pgpool > /dev/null 2>&1; then
        echo "[$(date -Iseconds)] [CRITICAL] ⚠️  pgpool process not running!"
        exit 1
    fi
    
    # Simple health check - try to connect to pgpool
    if ! psql -h localhost -p 5432 -U postgres -d postgres -c "SELECT 1" >/dev/null 2>&1; then
        echo "[$(date -Iseconds)] [WARNING] ⚠️  Cannot connect to pgpool on port 5432"
    fi
    
    # Log that monitoring is working (reduced frequency)
    if [ $(($(date +%s) % 300)) -eq 0 ]; then  # Every 5 minutes
        echo "[$(date -Iseconds)] [INFO] ✓ PgPool monitoring active"
    fi
done
