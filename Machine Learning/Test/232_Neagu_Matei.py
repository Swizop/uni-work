import numpy as np
from sklearn.neighbors import KNeighborsClassifier
from sklearn.preprocessing import binarize
from sklearn.utils import shuffle


# ___________________________ EX 1
testImages = np.reshape(np.load("var_3/testImages.npy"), (500, 28, 28))
trainImages = np.reshape(np.load("var_3/trainImages.npy"), (1200, 28, 28))
trainLabels = np.load("var_3/trainLabels.npy")

# print(len(trainImages))
# print(len(testImages))
def convert(tensor):
    print(len(tensor))
    nrImagini = len(tensor[0][0])
    imagini = [[] for _ in range(nrImagini)]
    for i in range(len(imagini)):
        imagini[i] = [[] for _ in range(len(tensor))]
    
    for pixelLinie in tensor:
        j = 0
        for pixelCol in pixelLinie:
            i = 0
            for pixel in pixelCol:
                imagini[i][j].append(pixel)
                i += 1
        j += 1
    # print(len(imagini), len(imagini[0]), len(imagini[0][0]))
    for i in range(len(imagini)):
        for j in range(len(imagini[i])):
            imagini[i][j] = np.array(imagini[i][j])
        imagini[i] = np.array(imagini[i], dtype=object)
    return np.array(imagini)


def binarizare(imagini):
    newImagini = []
    for img in imagini:
        newImagini.append(binarize(img, threshold=80))
    
    return np.array(newImagini)


def cuantificare(imagini):
    ls = []
    for imagine in imagini:
        listaImagine = []
        for linie in imagine:
            total = 0
            prev = None
            for x in linie:
                if x != prev:
                    if prev != None:
                        total += 1
                    prev = x
            listaImagine.append(total)
        ls.append(np.array(listaImagine))
    return np.array(ls)


testImages = convert(testImages)
trainImages = convert(trainImages)
print(np.shape(testImages), np.shape(trainImages))
testImages = binarizare(testImages)
trainImages = binarizare(trainImages)
cuantificareTest = cuantificare(testImages)
cuantificareTrain = cuantificare(trainImages)

#print(cuantificareTest)
# print(cuantificareTrain)
# print(np.shape(cuantificareTrain))
# print(np.shape(cuantificareTest))


# ________________________________________ EX 2

# PARTEA 1: scoring
# observam ca nu exista validation data, facem shuffle & split pentru scor
def train_and_score(train, eticheteTrain, test, eticheteTest):
    knnModel = KNeighborsClassifier(metric="minkowski", p=5, n_neighbors=3)
    knnModel.fit(train, eticheteTrain)
    knnModel.predict(test)
    print(knnModel.score(test, eticheteTest))

trainData, trainLabels = shuffle(cuantificareTrain, trainLabels)

# vom splitui in 3-imi
nrTaken = len(trainData) // 3
train1, labels1 = trainData[:nrTaken], trainLabels[:nrTaken]
train2, labels2 = trainData[nrTaken: 2 * nrTaken], trainLabels[nrTaken: 2 * nrTaken]
train3, labels3 = trainData[2 * nrTaken:], trainLabels[2 * nrTaken:]

train_and_score(np.concatenate((train1, train2)), np.concatenate((labels1, labels2)), train3, labels3)
train_and_score(np.concatenate((train1, train3)), np.concatenate((labels1, labels3)), train2, labels2)
train_and_score(np.concatenate((train2, train3)), np.concatenate((labels2, labels3)), train1, labels1)
# knModel.fit(cuantificareTrain, trainLabels)
# predictions = knModel.predict(cuantificareTest)
# np.tensordot