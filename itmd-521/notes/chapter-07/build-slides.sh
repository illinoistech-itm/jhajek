#!/bin/bash

#pandoc -t slidy -s sample.md -o sample.html
# -i is for iterative (slides advance one bullet point at a time)
pandoc -i -t slidy -s chapter-07.md -o chapter-07.html 
pandoc -t beamer chapter-07.md -o chapter-07.pdf