#!/bin/bash

# SQLite Remote Backup Script
# Usage: ./backup-sqlite.sh

# Configuration
SSH_HOST="root@10.10.1.3"
SSH_PASSWORD="aud100"
REMOTE_DB="/home/docker/vaultwarden/bitwarden/db.sqlite3"
LOCAL_BACKUP_DIR="/mnt/extra/backup/aldervall"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="backup_${TIMESTAMP}.db"

# Create backup directory if it doesn't exist
mkdir -p "$LOCAL_BACKUP_DIR"

echo "Starting SQLite backup..."
echo "Remote: ${SSH_HOST}:${REMOTE_DB}"
echo "Local: ${LOCAL_BACKUP_DIR}/${BACKUP_NAME}"

# Method 1: Using .backup command (recommended)
sshpass -p "$SSH_PASSWORD" ssh "$SSH_HOST" "sqlite3 '$REMOTE_DB' '.backup /tmp/temp_backup.db'"

if [ $? -eq 0 ]; then
  echo "Backup created on remote server, downloading..."
  sshpass -p "$SSH_PASSWORD" scp "${SSH_HOST}:/tmp/temp_backup.db" "${LOCAL_BACKUP_DIR}/${BACKUP_NAME}"

  if [ $? -eq 0 ]; then
    echo "Download complete, cleaning up remote temp file..."
    sshpass -p "$SSH_PASSWORD" ssh "$SSH_HOST" "rm /tmp/temp_backup.db"
    echo "✓ Backup successful: ${LOCAL_BACKUP_DIR}/${BACKUP_NAME}"

    # Optional: Create a symlink to latest backup
    ln -sf "${BACKUP_NAME}" "${LOCAL_BACKUP_DIR}/latest.db"

    # Optional: Show backup size
    SIZE=$(ls -lh "${LOCAL_BACKUP_DIR}/${BACKUP_NAME}" | awk '{print $5}')
    echo "Backup size: $SIZE"
  else
    echo "✗ Failed to download backup"
    exit 1
  fi
else
  echo "✗ Failed to create backup on remote server"
  exit 1
fi

# Optional: Keep only last 7 backups
echo "Cleaning old backups (keeping last 7)..."
cd "$LOCAL_BACKUP_DIR"
ls -t backup_*.db | tail -n +8 | xargs -r rm
echo "Done!"
