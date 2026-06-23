#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: migrate.sh
#  所在目录: backend
#  说明: 本文件为 migrate.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/bin/bash

# Exit on error
set -e

# Export Flask app
export FLASK_APP=${FLASK_APP:-run.py}

echo "Running database migrations..."

# Check if migrations directory exists
if [ ! -d "migrations" ]; then
    echo "Initializing migrations directory..."
    flask db init
fi

# Try to upgrade first (in case there are existing migrations)
echo "Attempting to upgrade existing migrations..."
flask db upgrade || true

# Create and apply new migration if needed
echo "Creating new migration if needed..."
flask db migrate -m "Auto-generated migration" || true

echo "Applying migrations..."
flask db upgrade

echo "Checking if seed data is needed..."
# Only run seed data if topics table is empty
PGPASSWORD="$DB_PASSWORD" psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USERNAME" -d "$DB_NAME" -t -c "SELECT COUNT(*) FROM topics" | grep -q "0" && {
    echo "Running seed data..."
    python seed_data.py
} || {
    echo "Database already contains data, skipping seed"
}

echo "Database setup completed successfully!"
