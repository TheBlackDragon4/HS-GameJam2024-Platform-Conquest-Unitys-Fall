import png
from PIL import Image  # Bibliothek zum be-/verarbeiten von Bilder

images = ['1 - Kopie.png', '1 - Kopie.png', '1 - Kopie.png', '2.png', '1.png', '2.png', '3.png', '3.png', '3.png']

w, h, p, m = png.Reader(filename=images[4]).read_flat()
print(w)
stand_pixelsize = 25
width = w + stand_pixelsize * 2
height = width

print(height, width, stand_pixelsize)

new_im = Image.new('RGBA', (width, height))

def copy_image(image, offset_x=0, offset_y=0):
    for i in range(0, width, height):
        im = Image.open(image)
        new_im.paste(im, (i + offset_x, offset_y))

copy_image(images[0], 0, 0)
copy_image(images[1], stand_pixelsize + int((w/stand_pixelsize-1)*stand_pixelsize/2), 0)
copy_image(images[2], stand_pixelsize + w, 0)
copy_image(images[3], 0, stand_pixelsize + int((w/stand_pixelsize-1)*stand_pixelsize/2))
copy_image(images[4], stand_pixelsize, stand_pixelsize)
copy_image(images[5], stand_pixelsize + w, stand_pixelsize + int((w/stand_pixelsize-1)*stand_pixelsize/2))
copy_image(images[6], 0, stand_pixelsize + w)
copy_image(images[7], stand_pixelsize + int((w/stand_pixelsize-1)*stand_pixelsize/2), stand_pixelsize + w)
copy_image(images[8], stand_pixelsize + w, stand_pixelsize + w)

new_im.save('output.png')
