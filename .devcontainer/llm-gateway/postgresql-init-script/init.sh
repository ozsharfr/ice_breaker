#!/bin/bash

set -euo pipefail

if psql -lqt | cut -d \| -f 1 | grep -qw langfuse; then
    echo "Langfuse database already exists, not seeding."
else
    psql -U postgres -f /docker-entrypoint-initdb.d/seed/seed_db.sql
fi
