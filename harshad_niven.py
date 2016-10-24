def harshad ():
    harshad = []
    for i in range(35,45):
        i = str(i)
        t_sum = 0
        for j in i:
            t_sum += int(j)
            print j,t_sum, i
        print "\n"
        if int(i)%t_sum == 0:
            harshad.append(i)
    return harshad

print harshad()
