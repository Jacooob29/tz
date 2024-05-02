
#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <input_dir> <output_dir>"
    exit 1
fi

input_dir="$1"
output_dir="$2"

if [ ! -d "$input_dir" ]; then
    echo "Source directory does not exist: $input_dir"
    exit 1
fi

if [ ! -d "$output_dir" ]; then
    echo "Output directory does not exist: $output_dir"
    exit 1
fi

files=$(find "$input_dir" -maxdepth 1 -type f)

dirs=$(find "$input_dir" -mindepth 1 -type d)

all_files=$(find "$input_dir" -type f)

find "$input_dir" -type f | \
    while read -r file; do
        file_extension=$(echo "$file" | awk -F. '{print $NF}')
        file_basename=$(basename "$file")
        cp "$file" "$output_dir/$file_basename"
        echo "Copied $file to $output_dir/$file_basename"
    done

echo "Files moved successfully."