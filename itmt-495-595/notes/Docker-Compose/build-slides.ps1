#pandoc -t slidy -s sample.md -o sample.html
# -i is for iterative (slides advance one bullet point at a time)
pandoc -i -t slidy -s docker-compose.md -o docker-compose.html 
pandoc -t beamer docker-compose.md -o docker-compose.pdf