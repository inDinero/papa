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

##### Sample Usage:

```
$ papa hotfix start -v 17.12.0
```

### Adding bugfix branches to a hotfix branch

This will rebase all new bugfix branches from the hotfix branch and then subsequently merge the updated bugfix branch into the release branch. The updated release branch will be pushed to origin.

```
$ papa hotfix add -v, --version=VERSION [-b, --bugfix-branches=one two three]
```

If `--bugfix-branches` is not specified, it will prompt a vi session where you can enter the branch names separated by line breaks.

##### Sample Usage:

If you want to specify the bugfix branches using `--bugfix-branches`:

```
$ papa hotfix add -v 17.12.0 -b bugfix/1 bugfix/2 bugfix/3
```

If you want to use vi to specify the bugfix branches:

```
$ papa hotfix add -v 17.12.0
```

### Finishing a hotfix branch

The finished hotfix branch will be merged to `master` and `develop`. The updated `master` and `develop` branches will be pushed to origin.

```
$ papa release hotfix -v, --version=VERSION
```

#### Sample Usage:

```
$ papa release hotfix -v 17.12.0
```

## `papa integration`

### Starting and deploying an integration branch

This will create a new integration branch based on the specified base branch. The integration branch will be pushed to origin. The new branch will then be deployed to Larga.

```
$ papa integration start -b, --base-branch=BASE_BRANCH [-h, --hostname=HOSTNAME]
```

#### Sample Usage:

```
$ papa integration start -b feature/dunder-mifflin-this-is-pam
```

If you want to specify a hostname for this environment:

```
$ papa integration start -b feature/we-were-on-a-break -h ross-and-rachel
```

## `papa sandbox`

### Generating a new sandbox

This will generate a git repository that you can use to test out `papa`.

```
$ papa sandbox generate
```
