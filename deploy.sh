echo "ready to deploy app to ec2...."
echo $FOO
echo "SOMEVAR is below"
echo $SOMEVAR
echo "MY_SECRET_ENV"
echo $MY_SECRET_ENV

bundle exec cap production deploy