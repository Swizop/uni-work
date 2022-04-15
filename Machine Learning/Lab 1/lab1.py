import numpy as np
from skimage import io

li = []
for i in range(9):
    image = np.load(f"images/car_{i}.npy")
    li.append(image)

li = np.array(li)
print(np.sum(li))

i = 1
maxi = np.sum(0)
indiceMax = 0
for im in li:
    nps = np.sum(im)
    print(f"Imagine {i}: {nps}")
    if nps > maxi:
        maxi = nps
        indiceMax = i
    i += 1

print(indiceMax)
print(li.shape)

mean_image = np.mean(li, axis=0)
# print(mean_image)
io.imshow(mean_image.astype(np.uint8))
io.show()

npStd = np.std(li, axis=0)
print(npStd)

newArr = []
for im in li:
    newArr.append((im - mean_image) / npStd)
newArr = np.array(newArr)

print(newArr)
for im in newArr:
    io.imshow(im.astype(np.uint8))
    io.show()

for im in li:
    io.imshow(im[200:300, 280:400].astype(np.uint8))
    io.show()

