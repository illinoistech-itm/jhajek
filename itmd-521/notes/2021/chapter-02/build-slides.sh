#!/bin/bash

#pandoc -t slidy -s sample.md -o sample.html
# -i is for iterative (slides advance one bullet point at a time)
pandoc -i -t slidy -s chapter-02.md -o chapter-02.html 
pandoc -t beamer chapter-02.md -o chapter-02.pdf