# Install Instructions

```bash
# -parallel-build=0 will build in parallel, 1 will build serial
# -mem-build-allocation tells how much memory to allocate to the vm while building (default to 2048)
# -headless-val true won't display the GUI install progress, false will.  Default is false
# -only=name-here -- replace name-here with the vagrant box name to build only that system
# -force will delete any leftover artifacts on a rebuild
packer build -parallel-builds=0 -var "mem-build-allocation=2048" -var "headless-val=false" -force ./aom-parallel-deploy-mixed-riemann-grafana-collectd.json
packer build -parallel-builds=0 -var "mem-build-allocation=2048" -var "headless-val=false" -force ./aom-parallel-deploy-mixed-hosts.json
```
