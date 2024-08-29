#!/bin/bash

echo "Directory Synchronization Script"
echo "--------------------------------"

# Function to synchronize local directory with remote directory
sync_directories() {
    local local_dir="$1"
    local remote_dir="$2"
    local remote_host="$3"

    # Check if local directory exists
    if [ ! -d "$local_dir" ]; then
        echo "Error: Local directory $local_dir does not exist."
        exit 1
    fi

    # Perform synchronization
    echo "Synchronizing $local_dir with $remote_host:$remote_dir..."
    rsync -avz --delete "$local_dir/" "$remote_host:$remote_dir/"

    if [ $? -eq 0 ]; then
        echo "Synchronization successful."
    else
        echo "Synchronization failed."
    fi
}

# Prompt user for the local directory, remote directory, and remote host
read -p "Enter the path to the local directory: " local_path
read -p "Enter the remote directory path: " remote_path
read -p "Enter the remote host (e.g., user@hostname): " remote_host

# Synchronize directories
sync_directories "$local_path" "$remote_path" "$remote_host"

echo "Synchronization process complete."
