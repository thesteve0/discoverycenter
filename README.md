# OpenShift Discovery Center
[![Build Status](https://travis-ci.org/openshift/discoverycenter.svg?branch=master)](https://travis-ci.org/openshift/discoverycenter)

This repo contains the AsciiDoc sources for the [OpenShift Discovery
Center](https://discover.openshift.com/).

## Development Setup
If you don't have a GitHub account, start by [creating a GitHub
account](https://github.com/join).  Fork the
[discoverycenter](https://github.com/openshift/discoverycenter) project to your GitHub
account.  Clone your newly forked repository into your local workspace:

    $ git clone git@github.com:[your user]/discoverycenter.git
    Cloning into 'discoverycenter'...
    remote: Reusing existing pack: 4745, done.
    remote: Total 4745 (delta 0), reused 0 (delta 0)
    Receiving objects: 100% (4745/4745), 1.92 MiB | 1.52 MiB/s, done.
    Resolving deltas: 100% (1475/1475), done.
    Checking connectivity... done

Add a remote ref to upstream for pulling future updates

    $ git remote add upstream https://github.com/openshift/discoverycenter.git

As a precaution, disable merge commits to your master branch

    $ git config branch.master.mergeoptions --ff-only

### Building w/Middleman
Middleman is a framework for creating static HTML sites. It requires that your
system have both `ruby` and `rubygems` already installed in some way.

First, install the `bundler` gem and then install Middleman and its
dependencies:

```bash
$ gem install bundler
$ bundle install
```

### Live Previews with Middleman
You can simply use Bundler to run Middleman in order to be able to preview your
changes locally:

```bash
$ bundle exec middleman server
```

You can now view the site at http://localhost:4567

Content on the live site will look exactly as it does in your development
environment. Please verify each of your changes *before* submitting a pull
request.

### Contributing
It's usually a good idea to start by [submitting an issue describing your
feedback or planned changes](https://github.com/openshift/discoverycenter/issues).

To contribute changes, first [setup your own local copy of this
project](#development-setup). Then, create a new branch (from `master`), to
track your changes:

1. Make sure you have all current changes from upstream/master:

        $ git pull --rebase upstream master

1. Push the pulled updates to your fork of discoverycenter on GitHub:

        $ git push

    Make sure there is an [issue](https://github.com/openshift/discoverycenter/issues)
    logged for your Bug Fix or Feature Request that you are working on here.

1. Create a simple topic branch to isolate that work (just a recommendation):

        $ git checkout -b my_cool_feature

1. Stage your changes and commit (one or more times):

        $ git add en/my-new-file.adoc  
        $ git commit -m 'ISSUE-XXX Making this awesome new feature'  
        $ git add en/another-new-file  
        $ git commit -m 'ISSUE-YYY Fixing this really bad bug'

1. Rebase your branch against the latest master (applies your patches on top of
master):

        $ git fetch upstream
        $ git rebase -i upstream/master
        # if you have conflicts fix them and rerun rebase
        # The -f, forces the push, alters history, see note below
        $ git push -f origin my_cool_feature

The -i triggers an interactive update which also allows you to combine commits,
alter commit messages etc. It's a good idea to make the commit log very nice for
external consumption. Note that this alters history, which while great for
making a clean patch, is unfriendly to anyone who has forked your branch.
Therefore you want to make sure that you either work in a branch that you don't
share, or if you do share it, tell them you are about to revise the branch
history (and thus, they will then need to rebase on top of your branch once you
push it out).

After completing your changes, test and review them locally.

Finally, [send us a `Pull
Request`](https://github.com/openshift/discoverycenter/compare) comparing your new
branch with `openshift/discoverycenter:master`.

When you're done, reset your development environment by repeating the steps in
this section: switch back to master, update your repo, and cut a new feature
branch (from `master`).

## Deployment
Once your pull request is merged into the official repository, it will
automatically be built and deployed by Travis CI.

## Review Process (for Administrators)
### Article Style
The Discovery Center source includes a style guide. Please make sure that any
submitted articles confirm to the style guide. This includes things like
introductions, set-up and conclusion sections, proper line breaks, and so on and
so forth.

### Merging and Pull Requests
Pull Requests should be able to be automatically merged using GitHub's web-based
tools.

To test PRs submissions locally, switch back to `master` and set up a local copy
of the contributed code:

1. Locate the upstream section for your GitHub remote in the .git/config file. It
looks like this:

        [remote "upstream"]
            fetch = +refs/heads/*:refs/remotes/upstream/*
            url = git@github.com:openshift/discoverycenter.git

1. Now add the line fetch = +refs/pull/*/head:refs/remotes/upstream/pr/* to this section.

        [remote "upstream"]
            fetch = +refs/heads/*:refs/remotes/upstream/*
            url = git@github.com:openshift/discoverycenter.git
            fetch = +refs/pull/*/head:refs/remotes/upstream/pr/*

1. Now fetch all the pull requests:

        $ git fetch upstream
        From github.com:openshift/discoverycenter
         * [new ref]         refs/pull/1000/head -> upstream/pr/1000
         * [new ref]         refs/pull/1002/head -> upstream/pr/1002
         * [new ref]         refs/pull/1004/head -> upstream/pr/1004
         * [new ref]         refs/pull/1010/head -> upstream/pr/1009
        ...

1. To check out a particular pull request:

        $ git checkout pr/999
        Branch pr/999 set up to track remote branch pr/999 from upstream.
        Switched to a new branch 'pr/999'

    If everything looks good, use the merge button on the pull request to merge in
    the changes.

Mentioning PR numbers in commit messages will automatically generate links:

```bash
git commit -m 'merging pull request #123, thanks for contributing!'
```

If the Pull Request requires additional work, add a comment on GitHub describing
the changes, and switch back to your repo's local `master` branch to its
previous state:

```bash
git checkout master
```
