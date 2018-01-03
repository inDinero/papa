# Usage

## Contents

* [papa release](#papa-release)
* [papa hotfix](#papa-hotfix)
* [papa integration](#papa-integration)
* [papa deploy](#papa-deploy)
* [papa sandbox](#papa-sandbox)

## `papa release`

### Starting a release branch

This will create a new release branch based on the current `develop` branch. The release branch will be pushed to origin.

```
$ papa release start -v, --version=VERSION
```

#### Sample Usage:

```
$ papa release start -v 17.12.0
```

### Adding feature branches to a release branch

This will rebase all new feature branches from the release branch and then subsequently merge the updated feature branch into the release branch. The updated release branch will be pushed to origin.

```
$ papa release add -v, --version=VERSION [-b, --feature-branches=one two three]
```

If `--feature-branches` is not specified, it will prompt a vi session where you can enter the branch names separated by line breaks.

#### Sample Usage:

If you want to specify the feature branches using `--feature-branches`:

```
$ papa release add -v 17.12.0 -b feature/1 feature/2 feature/3
```

If you want to use vi to specify the feature branches:

```
$ papa release add -v 17.12.0
```

### Finishing a release branch

The finished release branch will be merged to `master` and `develop`. The updated `master` and `develop` branches will be pushed to origin.

```
$ papa release finish -v, --version=VERSION
```

#### Sample Usage:

```
$ papa release finish -v 17.12.0
```

## `papa hotfix`

### Starting a hotfix branch

This will create a new hotfix branch based on the current `master` branch. The hotfix branch will be pushed to origin.

```
$ papa hotfix start -v, --version=VERSION
```

#### Sample Usage:

```
$ papa hotfix start -v 17.12.0
```

### Adding bugfix branches to a hotfix branch

This will rebase all new bugfix branches from the hotfix branch and then subsequently merge the updated bugfix branch into the release branch. The updated release branch will be pushed to origin.

```
$ papa hotfix add -v, --version=VERSION [-b, --bugfix-branches=one two three]
```

If `--bugfix-branches` is not specified, it will prompt a vi session where you can enter the branch names separated by line breaks.

#### Sample Usage:

If you want to specify the bugfix branches using `--bugfix-branches`:

```
$ papa hotfix add -v 17.12.0 -b bugfix/1 bugfix/2 bugfix/3
```

If you want to use vi to specify the bugfix branches:

```
$ papa hotfix add -v 17.12.0
```

### Deploying a hotfix branch to a hotfix environment

This will deploy the specified hotfix branch to a hotfix environment.

```
$ papa hotfix deploy -v, --version=VERSION
```

#### Sample Usage:

```
$ papa hotfix deploy -v 17.12.0
```

### Finishing a hotfix branch

The finished hotfix branch will be merged to `master` and `develop`. The updated `master` and `develop` branches will be pushed to origin.

```
$ papa release hotfix -v, --version=VERSION [-b, --additional-branches=one two three]
```

If `--additional-branches` is specified, the hotfix branch will also be merged to the specified branches.

#### Sample Usage:

```
$ papa release hotfix -v 17.12.0
```

If the hotfix branch will also be merged to a release branch:

```
$ papa hotfix finish -v 17.12.0 -b release/17.11.0
```

## `papa integration`

#### Starting an integration branch

This will create a new integration branch based on the specified base branch.

```
$ papa integration start -f, --base-branch=BASE_BRANCH
```

#### Sample Usage:

```
$ papa integration start -f feature/dunder-mifflin-this-is-pam
```

### Adding branches to an integration branch

This will rebase all branches from the integration branch (but will not push them to origin unlike hotfix and release!) and then subsequently merge the updated bugfix branch into the integration branch. The updated integration branch will be pushed to origin.

```
$ papa integration add -v, --version=VERSION [-b, --branches=one two three]
```

If `--branches` is not specified, it will prompt a vi session where you can enter the branch names separated by line breaks.

#### Sample Usage:

If you want to specify the feature branches using `-b`:

```
$ papa integration add -v 17.12.0 -b feature/1 feature/2 feature/3
```

If you want to use vi to specify the feature branches:

```
$ papa integration add -v 17.12.0
```

### Deploying an integration branch to an integration environment

This will deploy the specified integration branch to an integration environment.

```
$ papa integration deploy -v, --version=VERSION
```

#### Sample Usage:

```
$ papa integration deploy -v 17.12.7.18.20.30
```

## `papa sandbox`

### Generating a new sandbox

This will generate a git repository that you can use to test out `papa`.

```
$ papa sandbox generate
```
