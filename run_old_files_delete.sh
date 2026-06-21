#!/usr/bin/env bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# -----------------------------------------------------------------------------
# Copyright (c) 2026 Richard Bloch
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
# A bash script front-end to call old_files_delete.sh
# Version 1.3.0
#
# requirements:
#  --access to old_files_delete.sh
#
# inputs:
#  --None (runs with no inputs)
#
# outputs:
#  --None (side effect is the completion of the called script)
#

set -Eeuo pipefail

# -----------------------------------------------------------------------------
# [user-config]
# Adjust the target script path and its arguments to match your environment
#
# Absolute paths are used intentionally: cron jobs run with a minimal environment and no
# working-directory context, so relative paths and directory-of-script lookups (as used in
# old_files_delete.sh) aren't reliable here
#
readonly SCRIPT_PATH="/home/user/old-files-delete/old_files_delete.sh"
readonly TARGET_DIR="/opt/motion/media"
readonly DAYS_AGO=10

# 'exec' replaces this wrapper process with old_files_delete.sh instead of
# forking a child, and naturally propagates its exit status back to cron.
exec /usr/bin/env bash "$SCRIPT_PATH" -d "$TARGET_DIR" -n "$DAYS_AGO"
