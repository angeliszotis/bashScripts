#!/bin/bash

echo "Web Service Monitor"
echo "-------------------"

check_service_status() {
    local url="$1"
    local log_file="$2"
    
    # Send a request to the URL and get the HTTP status code
    local status_code=$(curl -o /dev/null -s -w "%{http_code}" "$url")

    echo "Checking URL: $url"
    echo "Status Code: $status_code"

    # Log the result
    echo "$(date): $url returned status code $status_code" >> "$log_file"

    # Check if the status code indicates an error (e.g., 4xx or 5xx)
    if [[ "$status_code" -ge 400 ]]; then
        echo "Error detected. Status code: $status_code" >> "$log_file"
        echo "Alert: $url is down or experiencing issues. Status code: $status_code"
    else
        echo "$url is up and running."
    fi
}

# Prompt user for the URL and log file path
read -p "Enter the URL of the web service to monitor: " service_url
read -p "Enter the path to the log file: " log_path

# Check the status of the web service
check_service_status "$service_url" "$log_path"

echo "Monitoring complete."
