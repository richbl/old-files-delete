# Old-Files-Delete
**Old-Files-Delete** (`old_files_delete.sh`) is a [bash](https://en.wikipedia.org/wiki/Bash_%28Unix_shell%29) script to recursively delete files older than (n) number of days.

`run_old_files_delete.sh` is a related script intended to be used for making unattended script calls into `old_files_delete.sh` (*e.g.*, running cron jobs).

## [<img src="https://cloud.githubusercontent.com/assets/10182110/18208786/ae5d76b2-70e5-11e6-9663-cfe47d13f4d9.png" width="150" />](https://github.com/richbl/a-bash-template)Developed with a Bash Template (BaT)

**Old-Files-Delete** uses a bash template (BaT) called **[A-Bash-Template](https://github.com/richbl/a-bash-template)** designed to make script development and command line argument management more robust, easier to implement, and easier to maintain. Here are a few of those features:

- Dependencies checker: a routine that checks all external program dependencies (*e.g.*, [sshpass](http://linux.die.net/man/1/sshpass) and [jq](https://stedolan.github.io/jq/))
- Arguments and script details--such as script description and syntax--are stored in the [JSON](http://www.json.org/) file format (*i.e.*, `config.json`)
- JSON queries (using [jq](https://stedolan.github.io/jq/)) handled through wrapper functions
- A script banner function automates banner generation, reading directly from `config.json`
- Command line arguments are parsed and tested for completeness using both short and long-format argument syntax (*e.g.*, `-u|--username`)
- Optional command line arguments are permissible and managed through the JSON configuration file
- Template functions organized into libraries to minimize code footprint in the main script

For more details about using a bash template, [check out the BaT sources here](https://github.com/richbl/a-bash-template).

## Requirements

 - An operational [bash](https://en.wikipedia.org/wiki/Bash_%28Unix_shell%29) environment (bash 4.3.2 used during development)
 -  One additional external program:
    + [jq](https://stedolan.github.io/jq/), for parsing the `config.json` file

While this package was written and tested under Linux (Ubuntu 15.10), there should be no reason why this won't work under other Unix-like operating systems.


## Basic Usage
**Old-Files-Delete** is run through a command line interface, so all of the command options are made available there.

Here's the default response when running `old_files_delete.sh` with no arguments:

	$ ./old_files_delete.sh

	 |
	 |  A bash script to recursively delete files older than (n) days
	 |    0.1.0
	 |
	 |  Usage:
	 |    old_files_delete.sh -d directory -n days_ago
	 |
	 |  -d, --directory  file directory
	 |  -n, --days_ago   last modified n days ago
	 |

	Error: directory argument (-d|--directory) missing.
	Error: days ago argument (-n|--days_ago) missing.

In this example, the program responds by indicating that the required script arguments must be set before proper operation.

When arguments are correctly passed, the script provides feedback on the success or failure of the script actions:

	$ ./old_files_delete.sh -d ~/desktop -n 6

	 |
	 |  A bash script to delete files older than (n) days
	 |    0.1.0
	 |
	 |  Usage:
	 |    old_files_delete.sh -d directory -n days_ago
	 |
	 |  -d, --directory  file directory
	 |  -n, --days_ago   last modified n days ago
	 |

	Deleting old files...

	Success.
