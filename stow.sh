#!/usr/bin/env bash

# --- Configuration ---
# Set strict mode for safer script execution
set -euo pipefail

# Source directory containing the original dotfiles
SOURCE_DIR="$HOME/dotfiles_"
# Destination directory for the new stow-compatible structure
DEST_DIR="$HOME/dotfiles"

# List of packages whose configurations belong in ~/.config/
# The script will create the structure: <package_name>/.config/<package_name>/...
# uncomment below line and change it as wanted
# CONFIG_PACKAGES=("nvim" "waybar" "niri" "tmux" "foot")

# --- End of Configuration ---

# --- Main Script ---

# 1. Pre-flight Checks
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory '$SOURCE_DIR' not found. Please check the SOURCE_DIR variable."
    exit 1
fi

if [ -e "$DEST_DIR" ]; then
    echo "Error: Destination directory '$DEST_DIR' already exists. Please remove or rename it first."
    exit 1
fi

echo "Starting dotfiles restructuring..."
echo "Source: $SOURCE_DIR"
echo "Destination: $DEST_DIR"
echo "----------------------------------------"

mkdir -p "$DEST_DIR"

# 2. Process all items in the source directory
for item_path in "$SOURCE_DIR"/*; do
    item_name=$(basename "$item_path")

    # --- Handle Directories (Stow Packages) ---
    if [ -d "$item_path" ]; then
        # Check if the directory should be excluded
        is_excluded=false
        for excluded in "${EXCLUDE_PACKAGES[@]}"; do
            if [[ "$item_name" == "$excluded" ]]; then
                echo "-> Excluding package: $item_name"
                is_excluded=true
                break
            fi
        done
        [[ "$is_excluded" == true ]] && continue

        # Check if it's a package destined for ~/.config/
        is_config_pkg=false
        for pkg in "${CONFIG_PACKAGES[@]}"; do
            if [[ "$item_name" == "$pkg" ]]; then
                echo "--> Processing '.config' package: $item_name"
                # The target path inside the stow package mirrors the path from $HOME
                target_path="$DEST_DIR/$item_name/.config/$item_name"
                mkdir -p "$target_path"

                # Move all contents (including hidden files) into the new structure
                # We use a subshell with shopt to safely handle empty dirs and not affect the script's global settings
                (
                    shopt -s dotglob nullglob
                    files=("$item_path"/*)
                    if [ ${#files[@]} -gt 0 ]; then
                        for file in "${files[@]}"; do
                            # Skip if the target already exists
                            if [ -e "$target_path/$(basename "$file")" ]; then
                                echo "Warning: '$target_path/$(basename "$file")' already exists. Skipping..."
                            else
                                mv "$file" "$target_path/"
                                echo "    Moved '$file' to $target_path"
                            fi
                        done
                    else
                        echo "    No contents to move for $item_name"
                    fi
                )

                is_config_pkg=true
                break
            fi
        done
        [[ "$is_config_pkg" == true ]] && continue

        # --- Handle Home Directory Packages ---
        # If not a config package and not excluded, it's a "home" package (e.g., zsh, tmux)
        echo "--> Processing 'home' package: $item_name"
        target_path="$DEST_DIR/$item_name"
        mkdir -p "$target_path"

        # Move contents if the directory is not empty
        (
            shopt -s dotglob nullglob
            files=("$item_path"/*)
            if [ ${#files[@]} -gt 0 ]; then
                for file in "${files[@]}"; do
                    # Skip if the target already exists
                    if [ -e "$target_path/$(basename "$file")" ]; then
                        echo "Warning: '$target_path/$(basename "$file")' already exists. Skipping..."
                    else
                        mv "$file" "$target_path/"
                        echo "    Moved '$file' to $target_path"
                    fi
                done
            else
                echo "    No contents to move for $item_name"
            fi
        )

    # --- Handle Files in Root (e.g., README.md) ---
    elif [ -f "$item_path" ]; then
        echo "--> Processing root file: $item_name"
        if [ -e "$DEST_DIR/$item_name" ]; then
            echo "Warning: '$DEST_DIR/$item_name' already exists. Skipping..."
        else
            mv "$item_path" "$DEST_DIR/"
            echo "    Moved '$item_path' to $DEST_DIR"
        fi
    fi
done

echo ""
echo "----------------------------------------"
echo "✅ Restructuring complete!"
echo ""
echo "Next steps:"
echo "1. Review the new structure in '$DEST_DIR'."
echo "   (Tip: run 'tree -L 4 $DEST_DIR')"
echo ""
echo "2. If everything looks correct, replace your old dotfiles directory:"
echo "   rm -rf '$SOURCE_DIR'"
echo "   mv '$DEST_DIR' '$SOURCE_DIR'"
echo ""
echo "3. Navigate to your new dotfiles directory and use stow:"
echo "   cd '$SOURCE_DIR'"
echo "   stow nvim"
echo "   stow i3"
echo "   # stow each package you need"
echo "----------------------------------------"
