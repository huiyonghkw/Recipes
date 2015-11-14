#!/bin/sh
# This file is to be used by git repo on server
# It should be a file called hooks/post-receive in the bare git repo
#set -xe
#set -e
time=`date`

#Check the remote git repository whether it is bare
IS_BARE=$(git rev-parse --is-bare-repository)
if [ -z "$IS_BARE" ]; then
    echo >&2 "==========tips=========="
    echo >&2 "fatal: post-receive: IS_NOT_BARE"
    exit 1
fi

#Check the deploy dir whether it exists
#SUBJECT=$(git log -1 --pretty=format:"%s")
#IS_DEPLOY=$(echo "$SUBJECT" | grep "deploy\]")

#IS_DEPLOY=$(git log -1 --pretty=format:"%s" | grep "\[deploy\]")

#if [ -z "$IS_DEPLOY" ]; then
#    echo >&2  "==========tips=========="
#    echo >&2  "not deploy code to production"
#    exit 1
#fi

unset GIT_DIR
DeployPath="/mnt/www/api.weipei.cc"

echo "=====================production api.weipei.cc====================="
cd $DeployPath
echo "deploying the api. weipei.cc"

#git pull origin master
git fetch --all
git reset --hard origin/master


echo "web server pull master code at time: $time."
echo "============================================================="
