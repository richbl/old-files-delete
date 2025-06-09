#!/bin/bash
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
# A bash script front-end to call old_files_delete.sh
# Version 1.2.1
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

/bin/bash /home/user/old-files-delete/old_files_delete.sh -d /opt/motion/media -n 10
