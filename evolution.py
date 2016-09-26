import string
import random
'''
Cool note on the matter of speed and evolution of this algorithms. Let's see that if we set the mutation_rate a lil'bit high
i.e. like 0.2 (20%) we will get quite close solutions very quickly, however, we won't or we are unlikely to get any realistic 
results that converge. In other words, when we have long expression, and set mutation high, we should reach like 80-90% accuracy
preaty rapidly, but it will take incredibly long time to make it 100%, because it will simply overshoot all the changes. However, setting 
mutation_rate to like 5% would cause slow, but gradual increase, and it will consequently increase its accuracy instead of oscillating
about 70%-90%. To see the difference "METHINKS IT IS LIKE A WEASEL" takes forever to converge with 20% (way more that several thousand gens)
but it only takes 17 generations to see the result wit 5%. Same goes for too big mutations, 50% or more, it is pretty much randomizing
each offspring every time, so it barely resembles the parent
'''
def fitness (exp, target):
    score = 0
    if len(exp) != len(target):
        return "Length mismatch"
    else:
        # exp = list(exp)
        # target= list(target)
        for i in range(0, len(target)):
            if  exp[i] == target[i]: 
                #print "Comparing...", exp[i], target[i]
                score += 1
        return float(score)/float(len(exp))
 
def mutate (species, mutation_rate):
#if mutation_rate = 10% and len(string) = 13
#then aproximately we expect 1.3 letters to mutate
    letters_to_mutate = int(round(mutation_rate * len(species) + 0.5)) # add noise random.randint(1,10)/10
    for i in range(0, letters_to_mutate):
        j = random.randint(0, len(species)-1)
        x = random.choice(string.ascii_uppercase)
        if j!=(len(species) - 1):
            species = species[:j] + x + species[j+1:]       
        else:
            species = species[:j] + x 
    return species

def runEvolution (target):
    mutation_rate = 0.05 # in %
    target = target.replace(" ","")
    target = target.upper()
    parent =""
    for i in range(0, len(target)):
        parent += random.choice(string.ascii_uppercase) 
    n_gen = 0
    print "Gen ",n_gen,": ", parent
    print "Fitness 0: ", fitness(parent, target)
    while (parent != target):
        contest = []
        score = []
        pscore = fitness(parent, target)
        #contest = [mutate(parent, mutation_rate) for i in range(0,10)] #Children, each parent has some 10 mutated children
        for i in range(0,1000):
            offspring = mutate(parent, mutation_rate)
            contest.append(offspring)
            rank = fitness(offspring,target)
            score.append(rank)
        #score = [fitness(contest[i], target) for i in range (0, len(contest))]
        if max(score) > pscore:
            index = score.index(max(score))
            parent = contest[index]
        n_gen += 1
        if n_gen%100 == 0:
            print "Best fitness: ",  max(score), pscore
            #print contest
            print "Gen ",n_gen, ": ", parent
    print "Gen ", n_gen, ": ", parent                       
#print fitness("OTY", "Hey")
runEvolution("METHINKS IT IS LIKE A WEASEL")


