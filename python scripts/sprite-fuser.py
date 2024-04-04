import png
from PIL import Image  # Bibliothek zum be-/verarbeiten von Bilder
import sys               

# Opening a file
# file1 = open('log.txt', 'w')
# file1.writelines(sys.argv)
# # Closing file
# file1.close()

print(sys.argv)

images = ['', '', '',
          '', '', '',
          '', '', '',
          'name']
# images = ['1.png', '1 - Kopie.png', '1.png', '2.png', '1.png', '2.png', '3.png', '3.png', '3.png']
# images = ["", "", "", "", "icons/dummy/Stick.png", "icons/dummy/stick.png", "", "", ""]

# images = ["", "", "icons/dummy/Stick.png", "", "", "", "", "", "icons/dummy/stick.png"]
# images[4] = "icons\dummy\stick.png"

for i in range(1, len(sys.argv)):
    images[i-1] = sys.argv[i]

print(sys.argv)    

widths = []
heights = []
stand_pixelsize = 40

for i in range(9):
    w = stand_pixelsize
    h = stand_pixelsize
    if images[i] != '':
        w, h, p, m = png.Reader(filename=images[i]).read_flat()
    widths.append(w)
    heights.append(h)

# print(w)
width = max(widths[0], widths[3], widths[6]) + max(widths[1], widths[4], widths[7]) + max(widths[2], widths[5], widths[8])
height = width

avg_widths = [max(widths[0], widths[3], widths[6]), max(widths[1], widths[4], widths[7]), max(widths[2], widths[5], widths[8])] 

new_im = Image.new('RGBA', (width, height))

def copy_image(image, offset_x=0, offset_y=0):
    for i in range(0, width, height):
        im = Image.open(image)
        new_im.paste(im, (i + offset_x, offset_y))

for i in range(9):
    if images[i] != '':
        y_offset = 0
        x_offset = 0
        if widths[i] != avg_widths[int((i)/3)]:
            y_offset = int((avg_widths[int((i)/3)]/widths[i]-1)/2*avg_widths[int((i)/3)]-widths[i]*2)
        if widths[i] != avg_widths[(i)%3]:
            x_offset = int((avg_widths[(i)%3]/widths[i]-1)/2*avg_widths[(i)%3]-widths[i]*2)
        x_pre_offset = int(i%3)
        y_pre_offset = int(i/3)
        # if x_pre_offset == 0:
        #     x_offset = x_offset 
        if x_pre_offset == 1:
            x_offset = x_offset + avg_widths[0]
        if x_pre_offset == 2:
            x_offset = x_offset + avg_widths[0] + avg_widths[1]
        # if y_pre_offset == 0:
        #     y_offset = y_offset
        if y_pre_offset == 1:
            y_offset = y_offset + avg_widths[0]
        if y_pre_offset == 2:
            y_offset = y_offset + avg_widths[0] + avg_widths[1]
        # if images[i] == "":
        #     copy_image("icons/temp/empty.png", x_offset*10000, y_offset*10000)
        # else:
        copy_image(images[i], x_offset, y_offset)
    # else:
    #     copy_image(None, )

# output_name = images[9]
# if images[9] == 'name':
#     output_name = ""
#     for i in range(9):
#         im = images[i].replace(".png", "")
#         output_name = f"{output_name}{im}"

# print(output_name, images[9])
# new_im.save(f"res://icons/temp/{output_name}.png")
new_im.save(f"icons/temp/weapon.png")
# print("weapon")
