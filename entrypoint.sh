#!/bin/bash

echo "Starting"
if [ $# -lt 4 ]
then
  echo "not enough arguments - need repo(without https:// at the start), login, pass and sha"
  exit
fi

git config --global user.name $2
git config --global user.email $2

echo "go to /opt"
cd /opt
echo "creating new folder"
mkdir mnist-serve
echo "go to new folder"
cd ./mnist-serve
echo $1
echo $2
echo "cloning repo"
git clone https://$1 
cd mnist-serve
ls -lsa
rm -rf ./export
cp -r /mnt/export ./
rm -rf /mnt/export
echo "mnist-serve" > README.md
ls -lsa
git add .
git commit -m "adding new version of the model to serve with sha $4"
git push https://$2:$3@$1