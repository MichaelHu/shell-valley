#!/bin/bash

WORKDIR=/home/hudamin/gitbook/ci
LATEST_REV_FILE=$WORKDIR/latest-my-docs
LAST_REV_FILE=$WORKDIR/last-my-docs
DIR=/home/hudamin/gitbook/docs/my-docs
GITBOOK=/home/hudamin/gitbook/gitbook/node_modules/.bin/gitbook

pushd $DIR

git pull origin master 2>&1 > /dev/null
git rev-parse master > $LATEST_REV_FILE

LATEST_REV=`cat $LATEST_REV_FILE`
LAST_REV=`cat $LAST_REV_FILE`
echo $LATEST_REV
echo $LAST_REV

if [ "$LATEST_REV" == "$LAST_REV" ]; then
    echo "nop"
else
    echo $LATEST_REV > $LAST_REV_FILE
    $GITBOOK install
	# must use `env`
    env ~/software/node/6.5.0/bin/node $GITBOOK install
    env ~/software/node/6.5.0/bin/node $GITBOOK build
fi

popd
