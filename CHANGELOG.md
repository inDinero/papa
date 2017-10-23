# Changelog

## 0.3.0
* Used open3 for easier output and exit status handling
* Added more descriptive output messages
* Prompt vi when no branches are specified in add

## 0.2.0
* Added `integration [start]`
* Added `deploy` via larga
* Hard reset local feature and bugfix branches to remote versions before adding

## 0.1.0
* Initial release
* Added `release [start, add, finish]`, `hotfix [start, add, finish]` and `sandbox [generate]` commands
* Added simple error handling for some git commands for when they fail
