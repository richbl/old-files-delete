#!/usr/bin/env bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# -----------------------------------------------------------------------------
# Copyright (c) 2025 Richard Bloch
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# -----------------------------------------------------------------------------
#
# A Bash Template (BaT) Project
# A bash script to recursively delete files older than (n) days
# Version 1.2.1
#
# requirements:
#  --jq program installed: used to parse /data/config.json
#
# inputs:
#  --initial directory
#  --number of days to reach back
#
# outputs:
#  --notification of script success/failure
#  --side-effect(s): older files deleted
#

#
# NOTE:
#   The string '[user-config]' is an indication that some user configuration
#   may be needed to customize this script
#
# FOR MORE INFORMATION:
#   This script was written using the BaT template. To learn more, refer to
#   the A-Bash-Template project (https://github.com/richbl/a-bash-template)
#

# -----------------------------------------------------------------------------
# Script library sources and declarations
#
EXEC_DIR="$(dirname "$(readlink -f "$0")")"
source "${EXEC_DIR}/bash-lib/general"
source "${EXEC_DIR}/bash-lib/args"

# [user-config] set any external program dependencies here
declare -a REQ_PROGRAMS=('jq')

# -----------------------------------------------------------------------------
# Perform script configuration, arguments parsing, and validation
#
check_program_dependencies "${REQ_PROGRAMS[@]}"
display_banner
scan_for_args "$@"
check_for_args_completeness

# -----------------------------------------------------------------------------
# [user-config]
# Any code from this point on is custom code, using the services provided by the bash-lib library
# available through the A-Bash-Template (https://github.com/richbl/a-bash-template) project
#

# -----------------------------------------------------------------------------
# Perform old file delete
#

# Declare script arguments (see config.json)
arg_dir_root="$(get_config_arg_value directory)"
arg_date_range="$(get_config_arg_value 'days ago')"
arg_file_pattern_match="$(get_config_arg_value 'file pattern match')"

if [ ! "$arg_file_pattern_match" ]; then
  arg_file_pattern_match="*"
fi

readonly arg_dir_root
readonly arg_date_range
readonly arg_file_pattern_match

# Verify existence of arg_dir_root
exist_directory "$arg_dir_root"

# Set Internal Field Separator to newline (ignore whitespace in names)
IFS=$'\n'

echo "Deleting old files..."
echo

if ! find -L "$arg_dir_root" -mtime +"$arg_date_range" -type f -name "$arg_file_pattern_match" -delete; then
  echo "Error: file delete did not complete."
  quit
else
  echo "Success."
fi

unset IFS
