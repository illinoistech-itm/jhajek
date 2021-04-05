"""
 Simple Python lambda  usage application.

 @author rambabu.posa
"""
# a few French first names that can be composed with Jean
frenchFirstNameList = ["Georges", "Claude","Philippe", "Pierre", "Francois", "Michel", "Bernard",
                       "Guillaume", "Andre", "Christophe", "Luc", "Louis"]

for name in frenchFirstNameList:
    print("{}  and Jean-{}  are different French first names!".format(name,name))

print("---------------------------------")

def foo(name):
    print("{}  and Jean-{}  are different French first names!".format(name,name))

for name in frenchFirstNameList:
    foo(name)


print("---------------------------------")
f = lambda name: name+" and Jean-"+name+"  are different French first names!"

for name in frenchFirstNameList:
    print(f(name))


