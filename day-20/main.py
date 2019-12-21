def next_current(current, direction):
    if direction == "CW":
        current += 1
        if current >= 5:
            current = 0
    else:
        current -= 1
        if current <= -1:
            current = 4
    return current

def has_largest(elfs):
    val = max(elfs)
    return elfs.count(val) == 1

def has_smallest(elfs):
    val = min(elfs)
    return elfs.count(val) == 1

def is_prime(n) :   
    if (n <= 1) : 
        return False
    if (n <= 3) : 
        return True
    if (n % 2 == 0 or n % 3 == 0) : 
        return False
    i = 5
    while(i * i <= n) : 
        if (n % i == 0 or n % (i + 2) == 0) : 
            return False
        i = i + 6
    return True
   
elfs = [0, 0, 0, 0, 0]

current = 0
steg = 0
max_steg = 1000740
direction = "CW"

for i in range(1, max_steg+1):
    if is_prime(i) and has_smallest(elfs):
        current = elfs.index(min(elfs))
        elfs[current] += 1
    elif i % 28 == 0:
        if direction == "CW":
            direction = "CCW"
        else:
            direction = "CW"

        current = next_current(current, direction)
        current = next_current(current, direction)
        elfs[current] += 1
    elif i % 2 == 0 and has_largest(elfs) and max(elfs) == elfs[current]:
        current = next_current(current, direction)
        elfs[current] += 1
    elif i % 7 == 0:
        elfs[4] += 1
        current = 4
    else:
        elfs[current] += 1

    current = next_current(current, direction)

print(max(elfs) - min(elfs))