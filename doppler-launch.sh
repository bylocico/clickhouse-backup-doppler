#!/bin/sh

CLICKHOUSE_BACKUP_BIN=""
for path in /usr/bin/clickhouse-backup /clickhouse-backup /usr/local/bin/clickhouse-backup clickhouse-backup; do
    if command -v "$path" >/dev/null 2>&1 || [ -f "$path" ]; then
        CLICKHOUSE_BACKUP_BIN="$path"
        break
    fi
done

if [ -z "$CLICKHOUSE_BACKUP_BIN" ]; then
    CLICKHOUSE_BACKUP_BIN="clickhouse-backup"
fi

exec "$CLICKHOUSE_BACKUP_BIN" "$@"
