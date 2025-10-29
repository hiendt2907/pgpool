FROM debian:bookworm-slim

# Install PostgreSQL client, pgpool2, and utilities
RUN apt-get update && apt-get install -y --no-install-recommends \
    pgpool2 \
    postgresql-client-15 \
    postgresql-client-common \
    curl \
    jq \
    gosu \
    && rm -rf /var/lib/apt/lists/*

# Create necessary directories
RUN mkdir -p /etc/pgpool-II /var/run/pgpool /var/log/pgpool /config \
    && chown -R postgres:postgres /etc/pgpool-II /var/run/pgpool /var/log/pgpool

# Copy configuration files to /config (will be copied to /etc/pgpool-II at runtime)
COPY pgpool.conf /config/
COPY pool_hba.conf /config/
COPY pcp.conf /config/

# Copy scripts
COPY entrypoint.sh /usr/local/bin/
COPY monitor.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

# Expose ports
# 5432 - PostgreSQL protocol
# 9898 - PCP (Pgpool Control Protocol)
# 9000 - Watchdog
# 9694 - Heartbeat
EXPOSE 5432 9898 9000 9694

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
