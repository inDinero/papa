# Papa [![Gem Version](https://badge.fury.io/rb/papa.svg)](https://badge.fury.io/rb/papa) [![Build Status](https://travis-ci.org/b-ggs/papa.svg?branch=master)](https://travis-ci.org/b-ggs/papa)

Helper tool for inDinero's git workflow. Ako ang papa mo.

## Contents

* [Getting Started](#getting-started)
* [Commands](#commands)
	* [papa release](#papa-release)
	* [papa hotfix](#papa-hotfix)
	* [papa integration](#papa-integration)
	* [papa deploy](#papa-deploy)
	* [papa sandbox](#papa-sandbox)

## Getting Started

Install `papa` from Rubygems.

```
$ gem install papa
```

That's it, you're ready to go!

## Usage

Detailed information about what these commands do can be found in [USAGE.md](https://github.com/b-ggs/papa/blob/master/USAGE.md).

### `papa release`

#### Starting a release branch

```
$ papa release start -v 17.12.0
```

#### Adding feature branches to a release branch

If you want to specify the feature branches using `-b`:

```
$ papa release add -v 17.12.0 -b feature/1 feature/2 feature/3
```

If you want to use vi to specify the feature branches:

```
$ papa release add -v 17.12.0
```

#### Finishing a release branch

```
$ papa release finish -v 17.12.0
```

### `papa hotfix`

#### Starting a hotfix branch

```
$ papa hotfix start -v 17.12.0
```

#### Adding bugfix branches to a hotfix branch


If you want to specify the bugfix branches using `-b`:

```
$ papa hotfix add -v 17.12.0 -b bugfix/1 bugfix/2 bugfix/3
```

If you want to use vi to specify the bugfix branches:

```
$ papa hotfix add -v 17.12.0
```

#### Finishing a hotfix branch

```
$ papa release hotfix -v 17.12.0
```

### `papa integration`

#### Starting and deploying an integration branch

```
$ papa integration start -b feature/dunder-mifflin-this-is-pam
```

If you want to specify a hostname for this environment:

```
$ papa integration start -b feature/we-were-on-a-break -h ross-and-rachel
```

### `papa sandbox`

```
$ papa sandbox generate
```
