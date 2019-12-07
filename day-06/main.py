import imageio
import numpy

im = imageio.imread('mush.png')

previous_pixel = []

answer = []
for row in im:
    new_row = []
    for pixel in row:
        if previous_pixel == []:
            previous_pixel = pixel
            new_row.append(pixel)
            continue
        
        [r, g, b] = pixel
        [p_r, p_g, p_b] = previous_pixel

        r ^= p_r
        g ^= p_g
        b ^= p_b

        new_row.append([r, g, b])

        previous_pixel = pixel
    answer.append(new_row)

imageio.imwrite('./answer.png', answer)