#!/bin/bash

# Include libraries
source ./resources/var.sh
source ./resources/functions.sh

# Params validation
if [ -z "$input_dir" ]; then
    echo 'input_dir: Value not set'
    exit 1
fi

if [ -z "$input_extension" ]; then
    echo 'input_extension: Value not set'
    exit 1
fi

if [ -z "$output_dir" ]; then
    echo 'output_dir: Value not set'
    exit 1
fi

if [ -z "$output_extension" ]; then
    echo 'output_extension: Value not set'
    exit 1
fi

if [ ! -d "$input_dir" ]; then
    echo "input_dir: $input_dir: No such directory"
    exit 1
fi

if [ ! -d "$output_dir" ]; then
    echo "output_dir: $output_dir: No such directory"
    exit 1
fi

# Sanitize

# Remove trailing slashes
input_dir="${input_dir%/}"
output_dir="${output_dir%/}"

# Convert to lowercase
input_extension="${input_extension,,}"
output_extension="${output_extension,,}"

liv_recurse "$input_dir" "$input_dir" "$input_extension" "$output_dir" "$output_extension"
