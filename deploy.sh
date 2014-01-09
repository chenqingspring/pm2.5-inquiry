echo "ready to deploy app to ec2...."
mkdir -p ~/.ssh
echo "start to generate private key..."
echo "-----BEGIN RSA PRIVATE KEY-----" >> ~/.ssh/credential.pem
for key in $(env | grep KEY[0-9]); do
    echo $key | cut -d "=" -f 2 >> ~/.ssh/credential.pem
done
echo -----END RSA PRIVATE KEY----- >> ~/.ssh/credential.pem
chmod 400 ~/.ssh/credential.pem
cat ~/.ssh/credential.pem
echo "private key generated!"
bundle exec cap production deploy
rm ~/.ssh/credential.pem