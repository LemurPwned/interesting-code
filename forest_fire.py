import random
from pprint import pprint
def display_forest(lattice):
    pprint(lattice)
def populate(lattice):
    #create lattice 100x100
    for i in range(0,10):
        lattice.append([])
        for j in range(0,10):
           lattice[i].append(0)
    #boundary conditions: empty cells at the boundaries
def plant(lattice):
#probability of cell to become a tree is p, e.g p = 0.5
    for i in range(1,9):
        for j in range(1,9):
            p = random.randint(0,1) #if p = 0.5
            if p > 0 and lattice[i][j] == 0:
                lattice[i][j] = 1 
    

def neighbourhood(lattice):
    lattice_ig = []
    populate(lattice_ig)
    for x in range(1,9):
        for y in range(1,9):
            if lattice[x][y] == 1:
                lattice_ig[x][y] = 1
                for i in {-1, 1}:
                    if (lattice[x+i][y+i] == -1) or (lattice[x+i][y] == -1) or (lattice[x][y+i] == -1) or (lattice[x+i][y-i] == -1):
                        lattice_ig[x][y] = -1       
            else:
                lattice_ig[x][y] = lattice[x][y]
    return lattice_ig

def ignite(lattice):
    for i in range(1,9):
        for j in range(1,9):
            f = random.randint(0,7) #f = 1/7
            #we say that there must be a tree to ignite, so 1
            if f == 0 and lattice[i][j] == 1:
                lattice[i][j] = -1
            else: continue

def fire():
    lattice = []
    populate(lattice)
    #seed trees
    plant(lattice)
    display_forest(lattice)
    print 
    #ignite!
    ignite(lattice)
    display_forest(lattice)
    print
    #update fire
    lattice = neighbourhood(lattice)
    display_forest(lattice)
'''
    #boundary conditions: empty cells at the boundary
    for i in range(0,100):
        lattice[i][0] = 0
        lattice[i][99] = 0
        lattice[0][i] = 0
        lattice[99][i] = 0
    return lattice
    '''
fire()
