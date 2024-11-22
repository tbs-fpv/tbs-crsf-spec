# Contributing

## Feedback and Change Requests

Please use the GitHub features for raising issues with the documentation or if you wish to contribute to the spec make a pull request.

## Pre-Commit Hook

This repository integrates [pre-commit](https://pre-commit.com) to detect and fix common errors (e.g., formatting and spelling). If you plan to raise a pull request, we recommend you install this repository's pre-commit hook to check your changes.

The pre-commit hook can be installed as follows (see pre-commit [documentation](https://pre-commit.com/#install) for full details).

```console
$ pip install pre-commit
$ cd ~/path/to/tbs-crsf-spec/repository
$ pre-commit install
```

Once installed, the pre-commit should run automatically whenever `git commit` is invoked. Pre-commit will check all staged changes using various pre-commit hooks.

> [!NOTE]
> Pre-commit can also be triggered manually by calling `pre-commit`

```console
$ git add some_file.md
$ git commit
check yaml...........................................(no files to check)Skipped
check illegal windows names..........................(no files to check)Skipped
check for merge conflicts................................................Passed
fix end of files.........................................................Failed
- hook id: end-of-file-fixer
- exit code: 1
- files were modified by this hook

Fixing some_file.md

mixed line ending........................................................Passed
trim trailing whitespace.................................................Passed
codespell................................................................Passed
```

If an error is found, please fix the issue, restage the fixed files using `git add`, then retry `git commit`.

> [!NOTE]
> Some pre-commit hooks will automatically fix the issue. In that case, simply restage the file.

This repository's pre-commit hook can be uninstalled at any point as follows:

```console
$ cd ~/path/to/tbs-crsf-spec/repository
$ pre-commit uninstall
```
