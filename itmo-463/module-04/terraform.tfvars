# Recommend keeping this as a template and modify on the "server-side"
# This way you are not accidentally committing secrets to version control

instance-type          = "t2.micro"
key-name               = "vagrant-463-key-pair"
tag                    = "module-04"
tg-name                = "tf-example-lb-tg"
elb-name               = "production-lb-tf"
