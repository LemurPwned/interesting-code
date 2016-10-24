def luhn (serial):
    tmp_serial = ""
    odd_sum = 0
    even_dig = []
    for i in range(1, len(serial)+1):
        digit = serial[len(serial) - i]
        tmp_serial += digit
    for j in range(0,len(serial)):
        if (j+1)%2 == 0:
            even_dig.append(2*int(tmp_serial[j]))
        else:
            odd_sum += int(tmp_serial[j])
    print even_dig,"\n", odd_sum 
    for i in range(0, len(even_dig)):
        if even_dig[i] > 9:
            tmp = str(even_dig[i])
            even_dig[i] = int(tmp[0]) + int(tmp[1])
    print even_dig
    s = sum(even_dig) + odd_sum
    print s
    if s%10 == 0:
        return True
    else:
        return False
print luhn("5575310400593619")
