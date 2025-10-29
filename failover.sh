#!/bin/bash
# Failover script for pgpool-II
# This script is called when a backend node fails

# Parameters passed by pgpool
FAILED_NODE_ID=$1
FAILED_HOST_NAME=$2
FAILED_PORT=$3
FAILED_DATA_DIR=$4
NEW_PRIMARY_NODE_ID=$5
NEW_PRIMARY_HOST_NAME=$6
OLD_PRIMARY_NODE_ID=$7
OLD_PRIMARY_HOST_NAME=$8
OLD_PRIMARY_PORT=$9
OLD_PRIMARY_DATA_DIR=${10}
NEW_PRIMARY_PORT=${11}
NEW_PRIMARY_DATA_DIR=${12}

LOG_FILE="/var/log/pgpool/failover.log"

# Create log directory if not exists
mkdir -p /var/log/pgpool

# Log failover event
echo "[$(date)] Failover triggered:" >> "$LOG_FILE"
echo "  Failed node: $FAILED_NODE_ID ($FAILED_HOST_NAME:$FAILED_PORT)" >> "$LOG_FILE"
echo "  New primary: $NEW_PRIMARY_NODE_ID ($NEW_PRIMARY_HOST_NAME:$NEW_PRIMARY_PORT)" >> "$LOG_FILE"

# For now, this is a simple logging script
# In production, you might want to:
# - Send notifications
# - Update DNS records
# - Trigger monitoring alerts
# - Perform automatic recovery actions

echo "[$(date)] Failover completed successfully" >> "$LOG_FILE"
exit 0