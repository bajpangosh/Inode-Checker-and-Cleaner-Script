#!/bin/bash

# Function to check inode usage
check_inodes() {
    echo "Checking inode usage..."
    df -i
}

# Function to clean up old PHP session files
cleanup_php_sessions() {
    echo "Cleaning up old PHP session files..."
    echo "You can specify the number of days to delete old session files (default is 1 day)."
    read -p "Enter number of days (default 1): " days
    days=${days:-1} # Default to 1 day if no input is provided

    echo "Deleting PHP session files older than $days day(s)..."
    find /var/lib/lsphp/session/ -type f -mtime +$days -exec rm -f {} \;
    echo "Cleanup completed."
}

# Function to schedule automatic cleanup via cron
setup_cron_job() {
    echo "Setting up automatic cleanup of PHP session files..."
    echo "This will run the cleanup every day at 3 AM."
    (crontab -l ; echo "0 3 * * * find /var/lib/lsphp/session/ -type f -mtime +1 -exec rm -f {} \;") | crontab -
    echo "Cron job setup completed."
}

# Function to confirm cleanup
confirm_cleanup() {
    echo "Are you sure you want to clean up old PHP session files? This action is irreversible."
    read -p "Enter 'yes' to continue or 'no' to cancel: " confirm
    if [[ $confirm == "yes" ]]; then
        cleanup_php_sessions
    else
        echo "Cleanup cancelled."
    fi
}

# Main menu
while true; do
    echo "-------------------------------------"
    echo "Inode Checker and Cleaner Script"
    echo "-------------------------------------"
    echo "1. Check inode usage"
    echo "2. Clean up old PHP session files"
    echo "3. Set up automatic cleanup (Cron job)"
    echo "4. Exit"
    echo "-------------------------------------"
    read -p "Please choose an option (1-4): " option

    case $option in
        1)
            check_inodes
            ;;
        2)
            confirm_cleanup
            ;;
        3)
            setup_cron_job
            ;;
        4)
            echo "Exiting script. Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
    echo
done
