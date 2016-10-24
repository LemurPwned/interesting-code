from pprint import pprint

def ant():
    orientation  = [['N',[-1,0],[1,0]], ['E',[0,1],[0,-1]], ['S',[1,0],[-1,0]], ['W',[0,-1],[0,1]]] #orientation, left, right
    grid = []
    grid = construct(grid)
    position = [4,4]
    #yeah... so note that pprint is reversed, x with y grid[1][1] = 9
    p_orientation = 0
    grid[4][4] = 2 #just init
    print orientation[p_orientation][0], position
    show(grid) 
    for i in range(0,5):
        position, p_orientation, grid = move(position, grid, p_orientation, orientation)
        print orientation[p_orientation][0], position
        show(grid)

def move(position, grid, p_orientation, orientation):
    x = position[0]
    y = position[1]
    print position
    c_orientation = 0
    if grid[x][y] == 1: #black, turn left
        grid[x][y] = 0
        print "black square, turning left"
        x = x + orientation[p_orientation][1][0]
        y = y + orientation[p_orientation][1][1]
        c_orientation = (p_orientation-1)%4
        grid[x][y] = 2 #mark the ant
    else:
        grid[x][y] = 1 #change the color of the current square
        print "white square, turning right"
        x = x + orientation[p_orientation][2][0]
        y = y + orientation[p_orientation][2][1]
        c_orientation = (p_orientation+1)%4
        grid[x][y] = 2 #mark the ant
    position = [x,y]
    p_orientation = c_orientation
    return position, p_orientation, grid

def construct(grid):
    for i in range(0,9):
        grid.append([])
        for j in range(0,9):
            grid[i].append(0)
    return grid

def show(grid): #this is bad, reversed x,y find different function
    print
    pprint(grid)
        
ant()        
 
