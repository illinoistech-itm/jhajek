from proxmoxer import ProxmoxAPI
import configparser

# Read URL, username, and password from the config.ini file -- keeps hard coded values out of the document
# Requires a Proxmox user with proper permissions
# We can create a user and credentials for this purpose
config = configparser.ConfigParser()
config.read("config.ini")
# identify the unique VM tag you are looking for
UNIQUEIDTAG = ''
POSITIONOFUNIQUETAG = 1
# Create connection and authenticate to a Proxmox cluster
# The config.ini looks like this, none of the values are quoted

# [prxmx41]
# url: system41.rice.iit.edu   -- just the URL no pre or postfix
# user: username@pve
# pass: long string provided

node1 = "system35"
node2 = "system43"
#node3 = ""
proxmox = ProxmoxAPI(config.get("system1","url"), user=config.get("system1","user"), password=config.get("system1","pass"), verify_ssl=False)

prxmx1 = proxmox.nodes(node1).qemu.get()
prxmx2 = proxmox.nodes(node2).qemu.get()
#prxmx3 = proxmox.nodes(node3).qemu.get()

# Initialize empty lists to hold query results
runningvms = []
runningwithtagsvms = []

# node 1
# Loop through the first node to get all of the nodes that are of status running and that have the tag of the user
for vm in prxmx1:
  if vm['status'] == 'running' and vm['tags'].split(';')[POSITIONOFUNIQUETAG] == UNIQUEIDTAG:
    runningvms.append(vm)

# Loop through those running VMs to then get networking/IP information
for vm in runningvms:
  runningwithtagsvms.append(proxmox.nodes(node1).qemu(vm['vmid']).agent("network-get-interfaces").get())
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

# node 2
# Loop through the first node to get all of the nodes that are of status running and that have the tag of the user
for vm in prxmx1:
  if vm['status'] == 'running' and vm['tags'].split(';')[1] == UNIQUEIDTAG:
    runningvms.append(vm)

# Loop through those running VMs to then get networking/IP information
for vm in runningvms:
  runningwithtagsvms.append(proxmox.nodes(node2).qemu(vm['vmid']).agent("network-get-interfaces").get())
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
