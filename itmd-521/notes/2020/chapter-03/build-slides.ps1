#pandoc -t slidy -s sample.md -o sample.html
# -i is for iterative (slides advance one bullet point at a time)
pandoc -i -t slidy -s chapter-03.md -o chapter-03.html 
pandoc -t beamer chapter-03.md -o chapter-03.pdf