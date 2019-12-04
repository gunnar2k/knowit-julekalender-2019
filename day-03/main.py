from PIL import Image, ImageDraw

width = 858 
height = 840

file = [char for char in open("img.txt").read()]
img = [file[i * width:(i + 1) * width] for i in range((len(file) + width - 1) // width )] # https://www.geeksforgeeks.org/break-list-chunks-size-n-python/

out = Image.new('RGB', (width, height), color = 'white')
draw = ImageDraw.Draw(out)

for x, row in enumerate(img):
    for y, col in enumerate(row):
        if img[x][y] == "1":
            draw.point((y,x),fill="black")

out.save('solution.png')