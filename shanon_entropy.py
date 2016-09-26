import string
import math

#this is intensive entropy i.e. per unit size (kilogram, mole etc.)
#now extensive entropy is S = H2*N (where H2 is intensive entropy)
#Normalized specific entropy is given by formula:
#Hn = (H2 * log(2)) / log(n) 
#Normalized extensixe (total) entropy
#Sn = (H2*N * log(2))/log(n)  
def shanon_entropy(variable):
    #calculate independent chars:
    count = unique(variable)
    N = len(variable)
    entropy = 0
    #n is number of unique symbols
    for el in count:
        if el[1] != 0:
            n += 1
            dom = float(el[1])/float(N)   
            entropy += dom*math.log(dom,2)
    return entropy*(-1),n

def normalize (entropy,n):
    n_entropy = ((entropy) * log(2))/log(n)
    return n_entropy

def unique(variable):
    symbols_unique = []
    for symbol in {0,1,2,3,4,5,6,7,8,9}:
        count = 0
        for i in range(0, len(variable)):
            if str(symbol) == variable[i]:
                count += 1
        symbols_unique.append((symbol, count))
    return symbols_unique

print shanon_entropy("1223334444")
