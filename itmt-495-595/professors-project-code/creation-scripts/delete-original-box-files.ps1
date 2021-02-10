Set-Location -path ../../build

if (Test-Path -Path ./*.box -PathType Leaf) {
    Remove-Item -Verbose *.box
}
else {
    Write-Host "No .box files to delete"
}

Set-Location -path ../professors-project-code/creation-scripts
