#!/bin/bash

echo "Starting"
if [ $# -lt 4 ]
then
  echo "not enough arguments - need repo(without https:// at the start), login, pass and sha"
  exit
fi

cd /opt
git clone https://$1
cd mnist-serve
ls -lsa
rm -rf ./export
cp -r /mnt/export ./
echo "mnist-serve" > README.md
ls -lsa
git add .
git commit -m "adding new version of the model to serve with sha $4"
git push https://$2:$3@$1