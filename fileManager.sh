#!/bin/bash

printf "\nFile Manager Start\n"

# Prompt user for initial input
printf "Give path: "
read path

# Function to check if directory exists
check_directory_exists() {
    if [ ! -d "$path" ]; then
        echo "Error: Directory $path does not exist."
        exit 1
    fi
}

check_directory_exists

# Main loop for user actions
while true; do
    printf "What you want to do write \n 1-Move to new Directory \n 2-Remove files \n 3-Move to existing directory \n 4-Exit \nGive: "
    read status

    case $status in
        1)
            # Move to new directory
            echo "Give file type (e.g., *.txt):"
            read filetype

            # List files of given type
            echo "Files to be moved:"
            ls $path | grep "$filetype"

            echo "Give name of directory to create:"
            read namedir

            # Create directory and move files
            mkdir -p "$path/$namedir"
            mv $path/$filetype "$path/$namedir"

            # List contents of the new directory
            echo "Contents of $path/$namedir:"
            ls "$path/$namedir"
            ;;

        2)
            # Remove files
            echo "Give type of file you want to remove (e.g., *.txt):"
            read filetype
            rm $path/$filetype
            echo "Files after removal:"
            ls $path
            ;;

        3)
            # Move to existing directory
            echo "Give type of file you want to move (e.g., *.txt):"
            read filetype
            echo "Give path of existing directory to move to:"
            read path2

            # Check if destination directory exists
            if [ ! -d "$path2" ]; then
                echo "Error: Directory $path2 does not exist."
                continue
            fi

            mv $path/$filetype "$path2"
            echo "Files moved to $path2:"
            ls "$path2"
            ;;

        4)
            # Exit the script
            echo "End File Manager"
            exit 0
            ;;

        *)
            echo "Invalid option. Please choose 1, 2, 3, or 4."
            ;;
    esac
done
