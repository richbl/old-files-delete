# Old-Files-Delete
**Old-Files-Delete** (`old_files_delete.sh`) is a [bash](https://en.wikipedia.org/wiki/Bash_%28Unix_shell%29) script to recursively delete files older than (n) number of days.

`run_old_files_delete.sh` is a related script intended to be used for making unattended script calls into `old_files_delete.sh` (*e.g.*, running cron jobs).

## [Developed with a Bash Template (BaT)](https://github.com/richbl/a-bash-template)[<img src="https://user-images.githubusercontent.com/10182110/145758715-b127adfc-710b-49d3-9ede-151adc83ae76.png" width="150" />](https://github.com/richbl/a-bash-template)

**Old-Files-Delete** uses a Bash shell template (BaT) called **[A-Bash-Template](https://github.com/richbl/a-bash-template)** designed to make script development and command line argument management more robust, easier to implement, and easier to maintain. Here are a few of those features:

- Dependencies checker: a routine that checks all external program dependencies (*e.g.*, [jq](https://stedolan.github.io/jq/))
- Arguments and script details--such as script description and syntax--are stored in the [JSON](http://www.json.org/) file format (*i.e.*, `config.json`)
- JSON queries (using [jq](https://stedolan.github.io/jq/)) handled through wrapper functions
- A script banner function automates banner generation, reading directly from `config.json`
- Command line arguments are parsed and tested for completeness using both short and long-format argument syntax (*e.g.*, `-f|--font`)
- Optional command line arguments are permissible and managed through the JSON configuration file
- Template functions organized into libraries (see the [Bash-Lib](https://github.com/richbl/bash-lib) project for details) to minimize code footprint in the main script

For more details about using a bash template, [check out the BaT sources here](https://github.com/richbl/a-bash-template).

## Requirements

- An operational [Bash](https://en.wikipedia.org/wiki/Bash_%28Unix_shell%29) environment (Bash 5.1.8 used during development)
- One additional external program:
  - [jq](https://stedolan.github.io/jq/), for parsing the `config.json` file

While this package was initially written and tested under Linux (Ubuntu 21.10), there should be no reason why this won't work under other shells or Unix-like operating systems that support the `gsettings` application.

## Basic Usage
**Old-Files-Delete** is run through a command line interface, so all of the command options are made available there.

Here's the default response when running `old_files_delete.sh` with no arguments:

    $ ./old_files_delete.sh

    |
    |  A bash script to recursively delete files older than (n) days
    |    1.2.0
    |
    |  Usage:
    |    old_files_delete.sh -d directory -n days_ago
    |
    |  -d, --directory           file directory
    |  -n, --days_ago            last modified (n) or more days ago
    |  -f, --file_pattern_match  OPTIONAL: file pattern to match ('*.jpg')
    |

    Error: directory argument (-d|--directory) missing.
    Error: days ago argument (-n|--days_ago) missing.

In this example, the program responds by indicating that the required script arguments must be set before proper operation.

When arguments are correctly passed, the script provides feedback on the success or failure of the script actions:

    $ ./old_files_delete.sh -d ~/desktop -n 6

    |
    |  A bash script to recursively delete files older than (n) days
    |    1.2.0
    |
    |  Usage:
    |    old_files_delete.sh -d directory -n days_ago
    |
    |  -d, --directory           file directory
    |  -n, --days_ago            last modified (n) or more days ago
    |  -f, --file_pattern_match  OPTIONAL: file pattern to match ('*.jpg')
    |

    Deleting old files...

    Success.

Also, using the optional `-f` flag, **Old-Files-Delete** can be run to filter filenames, so file deletes can be specifically pattern matched ([globbing](https://en.wikipedia.org/wiki/Glob_(programming))). For example, if the use case is to delete files in `/home/user/pics` older than 10 days, but only to delete jpg images files, then the following script would be run:

    $ ./old_files_delete.sh -d ~/pics -n 10 -f '*.jpg'

    |
    |  A bash script to recursively delete files older than (n) days
    |    1.2.0
    |
    |  Usage:
    |    old_files_delete.sh -d directory -n days_ago
    |
    |  -d, --directory           file directory
    |  -n, --days_ago            last modified (n) or more days ago
    |  -f, --file_pattern_match  OPTIONAL: file pattern to match ('*.jpg')
    |

    Deleting old files...

    Success.

## Automation with Cron

Perhaps the most powerful use case for **Old-Files-Delete** is the automated, regular execution of this script using a job scheduler such as [cron](https://en.wikipedia.org/wiki/Cron). **Old-Files-Delete** can be installed, a cron job created and saved, and then promptly forgotten: cron will periodically run the script, removing old files as they go out of date.

The example below represents my own cron job set to run nightly at 00:15 on my Raspberry Pi devices configured as surveillance cameras running the [Distributed-Motion-Surveillance](https://github.com/richbl/distributed-motion-surveillance) project:

	# run periodic file delete on motion image files
	15 0 * * * /bin/bash /home/pi/dev/old-files-delete/run_old_files_delete.sh

As configured, I no longer have to worry about motion-captured image files (jpg and avi files) getting generated over time, and eventually consuming available disk space on my IoT device.

## IMPORTANT: This Project Uses Git Submodules  <img src="https://user-images.githubusercontent.com/10182110/208980142-08d4cf6e-20ac-4243-ac69-e056258b0315.png" width="150" />

This project uses a Git [submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules) project, specifically the `bash-lib` folder to keep this project up-to-date without manual intervention.

So, be sure to clone this project with the `--recursive` switch (`git clone --recursive https://github.com/richbl/this_project`) so any submodule project(s) will be automatically cloned as well. If you clone into this project without this switch, you'll likely see empty submodule project folders (depending on your version of Git).
