#!/bin/bash

#pandoc -t slidy -s sample.md -o sample.html
# -i is for iterative (slides advance one bullet point at a time)
pandoc -i -t slidy -s chapter-09.md -o chapter-09.html 
pandoc -t beamer chapter-09.md -o chapter-09.pdf