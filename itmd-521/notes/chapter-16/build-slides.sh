#!/bin/bash

#pandoc -t slidy -s sample.md -o sample.html
# -i is for iterative (slides advance one bullet point at a time)
pandoc -i -t slidy -s chapter-16.md -o chapter-16.html 
pandoc -t beamer -V linkcolor=blue chapter-16.md -o chapter-16.pdf