#!/bin/bash
# ./gt.sh dev1.0.0
# ./gt.sh uat1.0.0
# ./gt.sh prod1.0.0
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <tag_number>"
    echo "Example: $0 dev2.0.1"
    exit 1
fi
TAG_VERSION=$1
set -e
git tag $TAG_VERSION -a -m "Release $TAG_VERSION"
git push origin $TAG_VERSION
