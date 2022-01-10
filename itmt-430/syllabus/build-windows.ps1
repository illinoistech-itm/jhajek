# How to allow Powershell scripts to run
# From an elevated Powershell promt type: Set-ExecutionPolicy RemoteSigned
# answer Yes to all

## Get current timestamp
$STAMP=Get-Date(Get-Date).ToUniversalTime()-uformat "%m%d%Y-%H%M%S"

If (Test-Path "./output/pdf/itmt-430-spring-2022-Systems-Integration*"){
  Remove-Item ./output/pdf/*.pdf -Verbose
}Else{
  Write-Output "./output/pdf/itmt-430-spring-2022-Systems-Integration.pdf - File does not exist"
}

If (Test-Path "./output/docx/itmt-430-spring-2022-Systems-Integration*"){
  Remove-Item ./output/docx/*.docx -Verbose
}Else{
  Write-Output "./output/docx/itmt-430-spring-2022-Systems-Integration.docx - File does not exist"
}

If (Test-Path "./output/odt/itmt-430-spring-2022-Systems-Integration*"){
  Remove-Item ./output/odt/*.odt -Verbose
}Else{
  Write-Output "./output/odt/itmt-430-spring-2022-Systems-Integration.odt - File does not exist"
}
#######################################################################################################################
# PDF - for e-reader 
# If you want to create a PDF, you’ll need to have LaTeX installed. (See MacTeX on OS X, MiKTeX on Windows, or
# install the texlive package in linux.) Then do                
########################################################################################################################
pandoc -V geometry:margin=.75in -V paperwidth=6.14in -V paperheight=9.25in -V linkcolor=blue -V fontsize=10pt -V -s -t latex -o ./output/pdf/itmt-430-spring-2022-Systems-Integration-$STAMP.pdf syllabus.md
#############################################################################################################################
# DOCX - [Convert your Markdown file to Word (docx):](http://bob.yexley.net/generate-a-word-document-from-markdown-on-os-x/)#############################################################################################################################
pandoc -V fontsize=10pt -s -o ./output/docx/itmt-430-spring-2022-Systems-Integration-$STAMP.docx -f markdown -t docx syllabus.md

#####################
# ODT
#####################
pandoc -V fontsize=10pt -s -o ./output/odt/itmt-430-spring-2022-Systems-Integration-$STAMP.odt -f markdown -t odt syllabus.md