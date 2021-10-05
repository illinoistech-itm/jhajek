# How to allow Powershell scripts to run
# From an elevated Powershell promt type: Set-ExecutionPolicy RemoteSigned
# answer Yes to all

## Get current timestamp
$STAMP=Get-Date(Get-Date).ToUniversalTime()-uformat "%m%d%Y-%H%M%S"

If (Test-Path "./output/pdf/itmo-553-fall-2021-cloud-computing-technologies*"){
  Remove-Item ./output/pdf/*.pdf -Verbose
}Else{
  Write-Output "./output/pdf/itmo-553-fall-2021-cloud-computing-technologies.pdf - does not exist, moving on..."
}

If (Test-Path "./output/docx/itmo-553-fall-2021-cloud-computing-technologies*"){
  Remove-Item ./output/docx/*.docx -Verbose
}Else{
  Write-Output "./output/docx/itmo-553-fall-2021-cloud-computing-technologies.docx - does not exist, moving on..."
}

If (Test-Path "./output/odt/itmo-553-fall-2021-cloud-computing-technologies*"){
  Remove-Item ./output/odt/*.odt -Verbose
}Else{
  Write-Output "./output/odt/itmo-553-fall-2021-cloud-computing-technologies.odt - does not exist, moving on..."
}
#######################################################################################################################
# PDF - for e-reader 
# If you want to create a PDF, you’ll need to have LaTeX installed. (See MacTeX on OS X, MiKTeX on Windows, or
# install the texlive package in linux.) Then do                
########################################################################################################################
pandoc -V geometry:margin=.75in -V paperwidth=6.14in -V paperheight=9.25in -V linkcolor=blue -V fontsize=10pt -V -s -t latex -o ./output/pdf/itmo-553-fall-2021-cloud-computing-technologies-$STAMP.pdf ./syllabus/syllabus.md
#############################################################################################################################
# DOCX - [Convert your Markdown file to Word (docx):](http://bob.yexley.net/generate-a-word-document-from-markdown-on-os-x/)#############################################################################################################################
pandoc -V fontsize=10pt -s -o ./output/docx/itmo-553-fall-2021-cloud-computing-technologies-$STAMP.docx -f markdown -t docx .\syllabus\syllabus.md

#####################
# ODT
#####################
pandoc -V fontsize=10pt -s -o ./output/odt/itmo-553-fall-2021-cloud-computing-technologies-$STAMP.odt -f markdown -t odt .\syllabus\syllabus.md