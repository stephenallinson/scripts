import datetime
import os
import shutil

# Define the user home directory
home = "/home/stephen"

# Define the source directories and files
source = [
    f"{home}/.config/qtile",
    f"{home}/.config/alacritty",
    f"{home}/.config/atuin",
    f"{home}/.config/btop",
    f"{home}/.config/calcurse",
    f"{home}/.config/fish",
    f"{home}/.config/gtk-2.0",
    f"{home}/.config/gtk-3.0",
    f"{home}/.config/gtk-4.0",
    f"{home}/.config/kanshi",
    f"{home}/.config/mods",
    f"{home}/.config/ncspot",
    f"{home}/.config/nvim",
    f"{home}/.config/nwg-look",
    # f"{home}/.config/obsidian",
    f"{home}/.config/remmina",
    f"{home}/.config/rofi",
    f"{home}/.config/spotify-player",
    f"{home}/.config/swaylock",
    f"{home}/.config/swaync",
    f"{home}/.config/tmux",
    f"{home}/.config/wal",
    f"{home}/.config/zellij",
    f"{home}/.config/zoom.conf",
    f"{home}/.config/zoomus.conf",
    f"{home}/.bashrc",
    f"{home}/.ssh",
    f"{home}/goproj",
    f"{home}/homelab",
    f"{home}/hugo",
    f"{home}/scripts",
    f"{home}/wallpaper",
    f"{home}/.newsboat",
]

# Define the destination root
destination = f"{home}/backups/"


## BACKUP PROCESS ##
def init_folders():
    current_date = datetime.datetime.now().strftime("%Y%m%d")
    # Ensure that the backups directory exists
    if not os.path.exists(destination):
        os.makedirs(destination)
    # Set the backup directory
    backup_directory = os.path.join(destination, "backup_" + current_date)
    # Create the backup directory if it does not exist
    if not os.path.exists(backup_directory):
        # Create a backup directory with the current date
        backup_directory = os.path.join(destination, "backup_" + current_date)
        os.makedirs(backup_directory)

    return backup_directory


def backup_aur_packages(backup_directory):
    # Backup the list of AUR packages
    os.system(f"yay -Q > {backup_directory}/pkglist.txt")
    print("AUR package list backed up.")


def backup_dir_files(backup_directory):
    # Copy all files in the source directories and individual files to the backup directory
    for path in source:
        if os.path.isdir(path):  # path is a directory
            shutil.copytree(
                path,
                os.path.join(backup_directory, os.path.basename(path)),
                dirs_exist_ok=True,
            )
            print(f"DIRECTORY: {os.path.basename(path)} copied to {backup_directory}")
        elif os.path.isfile(path):  # path is a file
            shutil.copy2(path, backup_directory)  # copy2 preserves file metadata
            print(f"FILE: {path} copied to {backup_directory}")
    print("Backup completed.")


def main():
    backup_directory = init_folders()
    if not backup_directory:
        print("Backup directory could not be created.")
        return
    else:
        backup_aur_packages(backup_directory)
        backup_dir_files(backup_directory)


if __name__ == "__main__":
    main()
