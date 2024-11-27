from proxmoxer import ProxmoxAPI
import configparser

config = configparser.ConfigParser()
config.read("config.ini")

proxmox = ProxmoxAPI(config.get("prxmx41","url"), user=config.get("prxmx41","user"), password=config.get("prxmx41","pass"), verify_ssl=False)

prxmx41 = proxmox.nodes("system41").qemu.get()
prxmx42 = proxmox.nodes("system42").qemu.get()

runningvms = []
runningwithtagsvms = []
# Loop through the first node to get all of the nodes that are of status running and that have the tag of the user
for vm in prxmx41:
  if vm['status'] == 'running' and vm['tags'].split(';')[1] == 'studentproduction':
    runningvms.append(vm)

# Loop through those running VMs to then get networking/IP information
for vm in runningvms:
  runningwithtagsvms.append(proxmox.nodes("system41").qemu(vm['vmid']).agent("network-get-interfaces").get())
# Visualization debugging
# print(runningwithtagsvms[3]['result'])

print(len(runningwithtagsvms))
# Get length of network interfaces list
interfacelen = len(runningwithtagsvms)

for x in range(len(runningwithtagsvms)):
  print('VMID: ' + str(runningvms[x]['vmid']))
  print('VMSTATUS: ' + str(runningvms[x]['status']))
  print('VMTAG: ' + str(runningvms[x]['tags'].split(';')[1]))
  for y in range(len(runningwithtagsvms[x]['result'])):
    print(runningwithtagsvms[x]['result'][y]['ip-addresses'][0]['ip-address'])
    