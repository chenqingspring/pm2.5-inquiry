#!/bin/bash

mkdir -p ~/.ssh

echo "start to generate private key..."

echo "-----BEGIN RSA PRIVATE KEY-----" >> ~/.ssh/credential.pem
for i in `seq 2 22`; do
   eval echo \$KEY$i >> ~/.ssh/credential.pem
done
echo -----END RSA PRIVATE KEY----- >> ~/.ssh/credential.pem
chmod 400 ~/.ssh/credential.pem

echo "private key generated!"

echo "ready to deploy app to ec2...."

bundle exec cap production deploy
bundle exec cap production update_city_ranking:start
rm -rf ~/.ssh/credential.pem
