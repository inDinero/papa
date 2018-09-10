# Changelog

## 1.2.0
* Allow adding release branches to integration branches
* Hard reset build branch for integration-related tasks

## 1.1.0
* Allow merging release branches to other branches upon finishing by adding `-b` to `papa release finish`
* Upon starting a new release or hotfix branch, reset base branch from origin after checking out

## 1.0.0
* Add `whoami` and `hostname` to deployment message
* Hard reset build branch before starting `papa [hotfix, release] finish`

## 0.7.2
* Change log file file format to `{TIMESTAMP}_papa_{BUILD_TYPE}_{COMMAND}.log`
* Disallow the use of `papa [hotfix, release] add` with release and hotfix branches

## 0.7.1
* Add ability to specify subdomain/hostname when deploying integration branches
* Fetch only once when adding feature or bugfix branches to an integration branch

## 0.7.0
* All output will be logged to a log file in the current working directory
* Properly determine whether to build or redeploy an integration or hotfix environment
* Destroy old outdated integration or hotfix environments if a different branch is to be deployed
* Slack notifications for integration and hotfix deployments
* Add documentation for the `-b` option in `papa hotfix finish`
* Minor documentation formatting changes

## 0.6.3
* Fixed bug when cleaning up after a failed `git merge`
* Exit out of `papa [hotfix, release] finish` when one of the base branches fails to be merged on

## 0.6.2
* Reset build branch from origin every time a new branch is added

## 0.6.1
* Show output from `larga` in real time.

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
