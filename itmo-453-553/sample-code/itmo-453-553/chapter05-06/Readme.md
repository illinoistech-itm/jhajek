# Install Instructions

```bash
# -parallel-build=0 will build in parallel, 1 will build serial
# -mem-build-allocation tells how much memory to allocate to the vm while building (default to 2048)
# -headless-val true won't display the GUI install progress, false will.  Default is false
# -only=name-here -- replace name-here with the vagrant box name to build only that system
# -force will delete any leftover artifacts on a rebuild
packer build -parallel-builds=0 -var "mem-build-allocation=2048" -var "headless-val=true" -force ./aom-parallel-deploy-mixed-riemann-grafana-collectd.json
packer build -parallel-builds=0 -var "mem-build-allocation=2048" -var "headless-val=true" -force ./aom-parallel-deploy-mixed-hosts.json
```

## Setting up Mailer

In your email.clj file add this line, replacing the james@example.com

```clojure

(def email (mailer {:host "smtp.gmail.com" :user "hajek@hawk.iit.edu" :pass "passwordhere" :tls true :port 587 :from "riemann@example.com"}))
; URL to IIT student email https://ots.iit.edu/email/student-mail

```

For this library you need to disable secure Google Authentication (which might not be a good thing)
[https://myaccount.google.com/lesssecureapps](https://myaccount.google.com/lesssecureapps "Link to less secure apps for Gmail")
