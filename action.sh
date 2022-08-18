#!/bin/bash


set -euo pipefail
# Check if values file exists. Throw error if doesn't.
if [ ! -f $VALUES_FILE ]; then
 echo "⚠️ Values file - $VALUES_FILE - does not exist."
 exit 1
fi

# Get the KEY from the full path
KEY=$(echo $FULL_PATH | awk -F. '{print $NF}' )
# Get only the path to the key. 
KEY_PATH="."$(echo "${FULL_PATH%.*}")

# Check if key exists in path. Throw error if doesn't.
if [ $(yq ''$KEY_PATH' | has("'$KEY'")' ${VALUES_FILE}) != 'true' ]; then
  echo "⚠️ Key $FULL_PATH does not exist. Quitting"
  exit 1
else
  yq '.'$FULL_PATH' = "'$NEW_VALUE'"' -i ${VALUES_FILE}
fi 

git config user.name "$(git log -n 1 --pretty=format:%an)"
git config user.email "$(git log -n 1 --pretty=format:%ae)"

cd ./gitops

git add ${VALUES_FILE}
git commit -m "${COMMIT_MESSAGE}"
git push
