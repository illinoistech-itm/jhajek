# How to allow Powershell scripts to run
# From an elevated Powershell promt type: Set-ExecutionPolicy RemoteSigned
# answer Yes to all

## Get current timestamp
$STAMP=Get-Date(Get-Date).ToUniversalTime()-uformat "%m%d%Y-%H%M%S"
$DESC="opensource-admin"

### Build for 400 level Undergrad Course Syllabi
If (Test-Path "./output/pdf/itmo-463*"){
  Remove-Item ./output/pdf/*.pdf -Verbose
}Else{
  Write-Output "./output/pdf/itmo-463-$STAMP-$DESC.pdf - does not exist, moving on..."
}

If (Test-Path "./output/docx/itmo-463*"){
  Remove-Item ./output/docx/*.docx -Verbose
}Else{
  Write-Output "./output/docx/itmo-463-$STAMP-$DESC.docx - does not exist, moving on..."
}

If (Test-Path "./output/odt/itmo-463*"){
  Remove-Item ./output/odt/*.odt -Verbose
}Else{
  Write-Output "./output/odt/itmo-463-$STAMP-$DESC.odt - does not exist, moving on..."
}

### Build for 500 level Grad Course Syllabi
If (Test-Path "./output/pdf/itmo-563*"){
  Remove-Item ./output/pdf/*.pdf -Verbose
}Else{
  Write-Output "./output/pdf/itmo-563-$STAMP-$DESC.pdf - does not exist, moving on..."
}

If (Test-Path "./output/docx/itmo-563*"){
  Remove-Item ./output/docx/*.docx -Verbose
}Else{
  Write-Output "./output/docx/itmo-563-$STAMP-$DESC.docx - does not exist, moving on..."
}

If (Test-Path "./output/odt/itmo-563*"){
  Remove-Item ./output/odt/*.odt -Verbose
}Else{
  Write-Output "./output/odt/itmo-563-$STAMP-$DESC.odt - does not exist, moving on..."
}
###############################################################################
# Build for 400 level Undergrad Course
###############################################################################
# PDF - for e-reader 
# If you want to create a PDF, you’ll need to have LaTeX installed. (See MacTeX on OS X, MiKTeX on Windows, or
# install the texlive package in linux.) Then do                
###############################################################################
pandoc -V geometry:margin=.75in -V paperwidth=6.14in -V paperheight=9.25in -V linkcolor=blue -V fontsize=10pt -V -s -t latex -o ./output/pdf/itmo-463-$STAMP-$DESC.pdf ./syllabus463.md
###############################################################################
# DOCX - [Convert your Markdown file to Word (docx):](http://bob.yexley.net/generate-a-word-document-from-markdown-on-os-x/)###############################################################################
pandoc -V fontsize=10pt -s -o ./output/docx/itmo-463-$STAMP-$DESC.docx -f markdown -t docx .\syllabus463.md
#####################
# ODT
#####################
pandoc -V fontsize=10pt -s -o ./output/odt/itmo-463-$STAMP-$DESC.odt -f markdown -t odt .\syllabus463.md

###############################################################################
# Build for 500 level Grad Course
###############################################################################
# PDF - for e-reader 
# If you want to create a PDF, you’ll need to have LaTeX installed. (See MacTeX on OS X, MiKTeX on Windows, or
# install the texlive package in linux.) Then do                
###############################################################################
pandoc -V geometry:margin=.75in -V paperwidth=6.14in -V paperheight=9.25in -V linkcolor=blue -V fontsize=10pt -V -s -t latex -o ./output/pdf/itmo-563-$STAMP-$DESC.pdf ./syllabus563.md
###############################################################################
# DOCX - [Convert your Markdown file to Word (docx):](http://bob.yexley.net/generate-a-word-document-from-markdown-on-os-x/)###############################################################################
pandoc -V fontsize=10pt -s -o ./output/docx/itmo-563-$STAMP-$DESC.docx -f markdown -t docx .\syllabus563.md
#####################
# ODT
#####################
pandoc -V fontsize=10pt -s -o ./output/odt/itmo-563-$STAMP-$DESC.odt -f markdown -t odt .\syllabus563.md
