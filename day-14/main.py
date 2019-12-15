alphabet = [2,3,5,7,11]
alphabet_length = len(alphabet)
seq = [
    [2,2], [2,3]
]

max_total = 217532235
answer = 0
total = 4
group = 1
alphabet_index = 2
while total <= max_total:
    if total % 100000 == 0:
        print("index ", total)
    last = seq[group]
    for i in range(0, last[0]):
        nr = alphabet[alphabet_index % alphabet_length]
        seq.append([
            last[1], nr
        ])
        alphabet_index += 1
        if total >= max_total:
            print("answer", answer)
            exit()
        if nr == 7:
            answer += nr * last[1]
        total += last[1]
    group += 1