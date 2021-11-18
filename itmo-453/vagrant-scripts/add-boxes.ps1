$NAMES = "host1","host2","riemannb","graphitea","graphiteb","graphitemc","riemanna","riemannmc"

Set-Location ../../Downloads
$SYSTEMS = Get-ChildItem -File -Name ./*.box | Sort-Object 

# Initialize a counter
$i = 0

foreach ($SYSTEM in $SYSTEMS) 
  { 
       write-output "Adding system: "  $NAMES[$i] + $SYSTEM 
       vagrant box add $SYSTEM --name $NAMES[$i]  
       $i++
  } # end of foreach 

write-output "Finished adding returning to scripts directory!"
Set-Location -Path ..\Documents\itmo-453\
