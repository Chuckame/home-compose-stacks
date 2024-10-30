#!/usr/bin/env bash

## declare an array variable
declare -a secrets=("jwt_secret" "session_secret" "storage_encryption_key" "notifier_smtp_password")

mkdir -p secrets/authelia

## now loop through the above array
for secretName in "${secrets[@]}"
do
   if [ -f "secrets/authelia/$secretName" ]; then
      echo "$secretName exists, skipping generation."
   else
      echo "Generating $secretName secret."
      openssl rand -hex 36 > secrets/authelia/$secretName
   fi
done
