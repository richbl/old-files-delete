#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# -----------------------------------------------------------------------------
# Copyright (C) Business Learning Incorporated (businesslearninginc.com)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License at <http://www.gnu.org/licenses/> for
# more details.
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

# -----------------------------------------------------------------------------
# script declarations
#
shopt -s extglob
EXEC_DIR="$(dirname "$0")"
# shellcheck source=bash-lib/args
source "${EXEC_DIR}/bash-lib/args"

declare -a REQ_PROGRAMS=('jq')

# -----------------------------------------------------------------------------
# perform script configuration, arguments parsing, and validation
#

check_program_dependencies "${REQ_PROGRAMS[@]}"
display_banner
scan_for_args "$@"
check_for_args_completeness

# -----------------------------------------------------------------------------
# perform old file delete
#
echo "Deleting old files..."
echo
find $(get_config_arg_value directory) -mtime +$(get_config_arg_value 'days ago') -type f -delete

if [ $? -ne 0 ]; then
  echo "Error: file delete did not complete."
  quit
else
  echo "Success."
fi
