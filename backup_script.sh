#!/bin/bash

# Backup Script

echo "Backup Script"
echo "-------------"

# Function to create a backup
create_backup() {
    local source_dir="$1"
    local backup_dir="$2"
    local timestamp=$(date +"%Y%m%d%H%M%S")
    local backup_file="$backup_dir/backup_$timestamp.tar.gz"

    if [ ! -d "$source_dir" ]; then
        echo "Error: Source directory $source_dir does not exist."
        exit 1
    fi

    if [ ! -d "$backup_dir" ]; then
        echo "Error: Backup directory $backup_dir does not exist. Creating it now."
        mkdir -p "$backup_dir"
    fi

    echo "Creating backup of $source_dir into $backup_file..."
    tar -czf "$backup_file" -C "$source_dir" .

    if [ $? -eq 0 ]; then
        echo "Backup successful: $backup_file"
        echo "$(date): Backup of $source_dir created at $backup_file" >> "$backup_dir/backup_log.txt"
    else
        echo "Backup failed."
    fi
}

# Prompt user for the source and backup directories
read -p "Enter the source directory to backup: " source_path
read -p "Enter the backup directory where the backup will be saved: " backup_path

# Create backup
create_backup "$source_path" "$backup_path"

echo "Backup process complete."
