# Changelog

## 0.3.0
* Used open3 for easier output and exit status handling
* Added more descriptive output messages
* Prompt vi when no branches are specified in add
* Improved sandbox path generation
* Added `papa sandbox clean` to remove old generated sandbox directories

## 0.2.0
* Added `papa integration [start]`
* Added `papa deploy` via larga
* Hard reset local feature and bugfix branches to remote versions before adding

## 0.1.0
* Initial release
* Added `papa release [start, add, finish]`, `papa hotfix [start, add, finish]` and `papa sandbox [generate]` commands
* Added simple error handling for some git commands for when they fail
