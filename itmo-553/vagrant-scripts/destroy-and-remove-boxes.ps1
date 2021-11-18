$SYSETMS = "graphitemc","graphiteb","graphitea","riemannmc","riemannb","riemanna","host1","host2"

foreach ($SYSTEM in $SYSETMS) 
  { 
     if ( Test-Path -Path $SYSTEM -PathType Container ) 
     {
       Set-Location $SYSTEM
       write-output "Entering directory: " $SYSTEM 
       vagrant halt && vagrant destroy -f && vagrant box remove -f $SYSTEM
       if ( Test-Path -Path .vagrant -PathType Container ) { Remove-Item .vagrant -Recurse }  
       Set-Location -Path ../
     } # end of if 
     else {
      write-output "Directory doesn't exist: " $SYSTEM
     } 
  } # end of foreach 
