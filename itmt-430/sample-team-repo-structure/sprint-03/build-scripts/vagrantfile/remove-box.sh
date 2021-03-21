vagrant halt
vagrant destroy -f
vagrant box remove sample-server
rm -rf ./.vagrant
rm ../../build/*.box

cd ../build-scripts/vagrantfile
