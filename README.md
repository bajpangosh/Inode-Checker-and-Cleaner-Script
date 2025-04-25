
# Inode Checker and Cleaner Script

This bash script helps you check the inode usage on your server and clean up old files (such as PHP session files) that are consuming inodes. It also allows you to automate this cleanup process by setting up a cron job.

## Features

- **Check Inode Usage**: Displays the current inode usage of the system.
- **Clean Up Old PHP Session Files**: Deletes PHP session files older than a specified number of days to free up inodes.
- **Set Up Automatic Cleanup (Cron Job)**: Schedules automatic daily cleanup of PHP session files via cron.
- **User-Friendly Interface**: Provides a simple menu-driven interface with easy-to-understand options.

## Requirements

- Ubuntu 22.04 (or any Linux-based system)
- Root or sudo access to the system to run commands that modify system files
- `find` command available (usually pre-installed on most Linux distributions)

## Installation

1. **Download the Script**:
   Save the script to your server (e.g., `inode_cleaner.sh`).

2. **Make the Script Executable**:
   After saving the script, make it executable by running:
   ```bash
   chmod +x inode_cleaner.sh
   ```

3. **Run the Script**:
   Execute the script by running:
   ```bash
   ./inode_cleaner.sh
   ```

## Usage

Upon running the script, you will be presented with a simple text menu. The options available are:

1. **Check Inode Usage**: Displays the current inode usage of the system.
2. **Clean Up Old PHP Session Files**: Removes PHP session files that are older than a specified number of days.
3. **Set Up Automatic Cleanup (Cron Job)**: Sets up a cron job to automatically clean up PHP session files every day at 3 AM.
4. **Exit**: Exits the script.

### Example of the menu:

```
-------------------------------------
Inode Checker and Cleaner Script
-------------------------------------
1. Check inode usage
2. Clean up old PHP session files
3. Set up automatic cleanup (Cron job)
4. Exit
-------------------------------------
Please choose an option (1-4):
```

### Cleaning Up PHP Session Files

- The script will prompt you to specify the number of days after which PHP session files should be deleted. If no value is provided, the default is **1 day**.
- The script will ask for confirmation before performing any deletions, ensuring no accidental file removal.

### Setting Up Cron Job

- The cron job will run every day at 3 AM and delete PHP session files older than 1 day.
- This cron job can be customized by modifying the script as needed.

## Example:

```
$ ./inode_cleaner.sh
-------------------------------------
Inode Checker and Cleaner Script
-------------------------------------
1. Check inode usage
2. Clean up old PHP session files
3. Set up automatic cleanup (Cron job)
4. Exit
-------------------------------------
Please choose an option (1-4): 2
Cleaning up old PHP session files...
You can specify the number of days to delete old session files (default is 1 day).
Enter number of days (default 1): 1
Deleting PHP session files older than 1 day...
Cleanup completed.
```

## Cron Job Example:

The script automatically adds the following cron job to clean up PHP session files daily at 3 AM:

```bash
0 3 * * * find /var/lib/lsphp/session/ -type f -mtime +1 -exec rm -f {} \;
```

## Troubleshooting

If you encounter any issues, ensure you have the necessary permissions to run the script with root or sudo privileges. If the cron job isn't running, check your cron service and ensure that the cron daemon is active and running.

## License

This script is provided "as-is" and is free to use. No warranties are provided for this software.
