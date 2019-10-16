#!/bin/bash

echo "Starting"
if [ $# -lt 4 ]
then
  echo "not enough arguments - need repo(without https:// at the start), login, pass and sha"
  exit
fi

git config --global user.name $3
git config --global user.email $3

cd /opt
mkdir mnist-serve
cd ./mnist-serve
git clone https://$2
cd mnist-serve
ls -lsa
rm -rf ./export
cp -r /mnt/export ./
rm -rf /mnt/export
ls -lsa
git add .
git commit -m "adding new version of the model to serve with sha $5"
git push https://$3:$4@$2