#!/bin/bash

# Disk Usage Analyzer Script

echo "Disk Usage Analyzer"
echo "-------------------"

# Function to display usage and largest files/directories
analyze_disk_usage() {
    local directory="$1"
    
    if [ ! -d "$directory" ]; then
        echo "Error: Directory $directory does not exist."
        exit 1
    fi

    echo "Analyzing disk usage for: $directory"
    echo

    # Display disk usage of the specified directory
    echo "Disk usage of $directory:"
    du -sh "$directory"

    echo
    echo "Top 10 largest directories in $directory:"
    du -ah "$directory" | sort -rh | head -n 10

    echo
    echo "Top 10 largest files in $directory:"
    find "$directory" -type f -exec du -h {} + | sort -rh | head -n 10
}

# Prompt user for the directory
read -p "Enter the directory path to analyze: " dir_path

# Analyze disk usage
analyze_disk_usage "$dir_path"

echo "Analysis complete."
