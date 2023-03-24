#!/bin/bash

password="okoń"

volume_name="test_volume"

temp_file=$(mktemp)

docker run --rm -v $volume_name:/data alpine tar -czf $temp_file /data

gpg --batch --passphrase "$password" --symmetric $temp_file
rm $temp_file

docker volume create $volume_name_encrypted
docker run --rm -v $volume_name_encrypted:/data alpine sh -c "mkdir /data/decrypted; gpg --batch --passphrase '$password' --decrypt /data/encrypted.tar.gz.gpg | tar -xz -C /data/decrypted"
docker run --rm -v $volume_name_encrypted:/data alpine ls /data/decrypted

docker volume rm $volume_name_encrypted
docker volume rm $volume_name
