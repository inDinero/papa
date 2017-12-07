# Changelog

## 0.6.0
* Added `papa hotfix deploy`
* Edited `papa integration start` to only start a new branch and not deploy to an environment.
* Added `papa integration add` and `papa integration deploy`
* Edited tasks so that they only run `git fetch` once

## 0.5.0
* Deprecated `papa deploy`. Deployment will be triggered during `papa integration start`.
* Simplified README.md and moved detailed command information into USAGE.md
* Changed integration branch naming scheme to include seconds in the branch name.

## 0.4.1
* Check whether build branch exists before prompting vi
* Add preceeding newlines in vi prompt
* Make success and error messages easier to read

## 0.4.0
* Classes have been housed into their own modules
* Minor change to how commands are run, but shouldn't affect functionality
* Code cleanup

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
