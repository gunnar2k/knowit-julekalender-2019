import csv

input = csv.reader(open("coords.csv"), delimiter=",")
next(input)

coords = [[int(line[0]), int(line[1])] for line in input]
current_coord = [0,0]

slime = {"0,0": 1}

answer = 0
for i, coord in enumerate(coords):
    [from_x, from_y] = current_coord
    [to_x, to_y] = coord

    diff_x = 1 if to_x > from_x else -1
    for x in range(from_x, to_x, diff_x):
        current_coord[0] += diff_x
        index = f'{current_coord[0],current_coord[1]}'
        if index in slime:
            slime[index] += 1
        else:
            slime[index] = 1
        answer += slime[index]
    
    diff_y = 1 if to_y > from_y else -1
    for y in range(from_y, to_y, diff_y):
        current_coord[1] += diff_y
        index = f'{current_coord[0],current_coord[1]}'
        if index in slime:
            slime[index] += 1
        else:
            slime[index] = 1
        answer += slime[index]
            
print(answer)
