#pandoc -t slidy -s sample.md -o sample.html
# -i is for iterative (slides advance one bullet point at a time)
pandoc -i -t slidy -s chapter-06.md -o chapter-06.html 
pandoc -t beamer chapter-06.md -o chapter-06.pdf