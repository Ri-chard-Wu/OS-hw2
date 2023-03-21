#!/bin/sh

cd ~/NachOS-4.0_MP2/code/

echo *.o > .gitignore
echo "first arg: ${1}"

git add *
git commit -m "${1}"
git push -u origin master