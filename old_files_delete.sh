#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# -----------------------------------------------------------------------------
# Copyright (C) Business Learning Incorporated (businesslearninginc.com)
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License at
# <http://www.gnu.org/licenses/> for more details.
#
# -----------------------------------------------------------------------------
#
# A bash script to recursively delete files older than (n) days
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
# script library sources and declarations
#
EXEC_DIR="$(dirname "$(readlink -f "$0")")"
source "${EXEC_DIR}/bash-lib/general"
source "${EXEC_DIR}/bash-lib/args"

# [user-config] set any external program dependencies here
declare -a REQ_PROGRAMS=('jq')

# -----------------------------------------------------------------------------
# perform script configuration, arguments parsing, and validation
#
check_program_dependencies "${REQ_PROGRAMS[@]}"
display_banner
scan_for_args "$@"
check_for_args_completeness

# -----------------------------------------------------------------------------
# [user-config]
# Any code from this point on is custom code, using the sevices provided
# through this BaT (https://github.com/richbl/a-bash-template) template

# -----------------------------------------------------------------------------
# perform old file delete
#

# declare script arguments (see config.json)
arg_dir_root="$(get_config_arg_value directory)"
arg_date_range="$(get_config_arg_value 'days ago')"
arg_file_pattern_match="$(get_config_arg_value 'file pattern match')"

if [ ! "$arg_file_pattern_match" ]; then
  arg_file_pattern_match="*"
fi

readonly arg_dir_root
readonly arg_date_range
readonly arg_file_pattern_match

# verify existence of arg_dir_root
exist_directory "$arg_dir_root"

# set Internal Field Separator to newline (ignore whitespace in names)
IFS=$'\n'

if ! find -L "$arg_dir_root" -mtime +"$arg_date_range" -type f -name "$arg_file_pattern_match" -delete; then
  echo "Error: file delete did not complete."
  quit
else
  echo "Success."
fi

unset IFS
