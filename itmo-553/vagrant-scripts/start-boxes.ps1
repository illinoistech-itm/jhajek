$SYSTEMS = "graphitemc","graphiteb","graphitea","riemannmc","riemannb","riemanna","host1","host2"

foreach ($SYSTEM in $SYSTEMS)
  {
       write-output "Starting system: " $SYSTEM
       Set-Location -Path $SYSTEM 
       vagrant up
       Set-Location -Path ../
    
  } # end of foreach
