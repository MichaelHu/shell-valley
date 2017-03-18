#!/bin/bash

WORKDIR=/home/irice/fe/ci
LATEST_REV_FILE=$WORKDIR/latest-sophon-help
LAST_REV_FILE=$WORKDIR/last-sophon-help
DIR=/home/irice/fe/docs/sophon-help
GITBOOK=/home/irice/fe/gitbook/node_modules/.bin/gitbook

echo "###########################"
date

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
    cd book
    # env ~/software/node/6.5.0/bin/node $GITBOOK install 
    env ~/software/node/6.5.0/bin/node $GITBOOK build 
    find . -maxdepth 1 -mindepth 1 -type d \
            -not -iregex '.*git$' -not -iregex '.*_book$' \
            -not -iregex '.*node_modules' -not -iregex '.*downloads' \
            -exec cp -r {} _book \;
    [ ! -e ../dist/help ] && mkdir -p ../dist/help
    find ../dist/help -maxdepth 1 -mindepth 1 | grep -v downloads | xargs rm -rf
    cp -r _book/* ../dist/help
fi

popd
