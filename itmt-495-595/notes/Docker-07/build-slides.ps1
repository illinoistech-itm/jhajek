#pandoc -t slidy -s sample.md -o sample.html
# -i is for iterative (slides advance one bullet point at a time)
pandoc -i -t slidy -s docker-07.md -o docker-07.html 
pandoc -t beamer docker-07.md -o docker-07.pdf