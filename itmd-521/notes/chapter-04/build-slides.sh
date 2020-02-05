#!/bin/bash

#pandoc -t slidy -s sample.md -o sample.html
# -i is for iterative (slides advance one bullet point at a time)
pandoc -i -t slidy -s chapter-04.md -o chapter-04.html 
pandoc -t beamer chapter-04.md -o chapter-04.pdf