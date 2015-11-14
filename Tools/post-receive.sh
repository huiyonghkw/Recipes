#!/bin/sh
#
# git autodeploy script when it matches the string "[deploy]"
#
# @author    icyleaf <icyleaf.cn@gmail.com>
# @link      http://icyleaf.com
# @version   0.1
#
# Usage:
#       1. put this into the post-receive hook file itself below
#       2. `chmod +x post-recive`
#       3. Done!

# Check the remote git repository whether it is bare
IS_BARE=$(git rev-parse --is-bare-repository)
if [ -z "$IS_BARE" ]; then
	echo >&2 "fatal: post-receive: IS_NOT_BARE"
	exit 1
fi

# Get the latest commit subject
SUBJECT=$(git log -1 --pretty=format:"%s")

# Deploy the HEAD sources to publish
IS_PULL=$(echo "$SUBJECT" | grep "\[deploy\]")
if [ -z "$IS_PULL" ]; then
	echo >&2 "tips: post-receive: IS_NOT_PULL"
	exit 1
fi

# Check the deploy dir whether it exists
DEPLOY_DIR=/home/icyleaf/php/icyleaf/
if [ ! -d $DEPLOY_DIR ] ; then
	echo >&2 "fatal: post-receive: DEPLOY_DIR_NOT_EXIST: \"$DEPLOY_DIR\""
	exit 1
fi

# Check the deploy dir whether it is git repository
#
#IS_GIT=$(git rev-parse --git-dir 2>/dev/null)
#if [ -z "$IS_GIT" ]; then
#	echo >&2 "fatal: post-receive: IS_NOT_GIT"
#	exit 1
#fi

# Goto the deploy dir and pull the latest sources
cd $DEPLOY_DIR
#env -i git reset --hard
env -i git pull
