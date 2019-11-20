from PIL import Image, ImageFilter

# https://docs.python-guide.org/scenarios/imaging/
# https://stackoverflow.com/questions/1386352/pil-thumbnail-and-end-up-with-a-square-image
#Read image and create a thumbnail
im = Image.open( 'data.png' )
size = (100, 100)
im.thumbnail(size, Image.ANTIALIAS)
background = Image.new('RGBA', size, (255, 255, 255, 0))
background.paste(
    im, (int((size[0] - im.size[0]) / 2), int((size[1] - im.size[1]) / 2))
)
background.save("thunbnail.png")