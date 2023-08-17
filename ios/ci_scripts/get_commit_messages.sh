#!/bin/bash

# Usage: ./get_commit_messages.sh <since_datetime> <output_file>

since_datetime="$1"
output_file="$2"

# Use git log to get commit messages since the specified date
git log --since="$since_datetime" --pretty=format:"%s" > "$output_file"
