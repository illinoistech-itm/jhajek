#pandoc -t slidy -s sample.md -o sample.html
# -i is for iterative (slides advance one bullet point at a time)
pandoc -i -t slidy -s stem.md -o stem.html 
pandoc -t beamer stem.md -o stem.pdf