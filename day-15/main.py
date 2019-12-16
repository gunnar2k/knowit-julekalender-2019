import csv

def signed_volume_of_triangle(p1, p2, p3):
    v321 = float(p3[0]) * float(p2[1]) * float(p1[2])
    v231 = float(p2[0]) * float(p3[1]) * float(p1[2])
    v312 = float(p3[0]) * float(p1[1]) * float(p2[2])
    v132 = float(p1[0]) * float(p3[1]) * float(p2[2])
    v213 = float(p2[0]) * float(p1[1]) * float(p3[2])
    v123 = float(p1[0]) * float(p2[1]) * float(p3[2])
    return (-v321 + v231 + v312 - v132 - v213 + v123)/6

data = open('MODEL.CSV')
csv_reader = csv.reader(data, delimiter=',')
answer = 0
for row in csv_reader:
    answer += signed_volume_of_triangle([row[0], row[1], row[2]], [row[3], row[4], row[5]], [row[6], row[7], row[8]])

print(round(answer/1000, 3))
