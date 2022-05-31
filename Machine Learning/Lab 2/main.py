import numpy as np
import matplotlib.pyplot as plt
from sklearn.naive_bayes import MultinomialNB
train_images = np.loadtxt('data/train_images.txt') # incarcam imaginile
test_images = np.loadtxt('data/test_images.txt')
train_labels = np.loadtxt('data/train_labels.txt', 'int') # incarcam etichetele avand  tipul de date int
test_labels = np.loadtxt('data/test_labels.txt', 'int')
# image = train_images[0, :] # prima imagine
# image = np.reshape(image, (28, 28))
# plt.imshow(image.astype(np.uint8), cmap='gray')
# plt.show()


def x_to_bins(x, bins):
    retVal = np.digitize(x, bins) # returneaza pentru fiecare element intervalul
    return retVal - 1

def values_to_bins(matrice, bins):
    newMatrice = []
    for img in matrice:
        # img = np.reshape(img, (28, 28))
        newImg = []
        for i in range(len(img)):
            newImg.append(x_to_bins(img[i], bins))
            #print(img[i])
        newMatrice.append(np.array(newImg))
    return np.array(newMatrice)

def show_accuracy(k):
    global train_images, test_images, train_labels, test_labels
    bins = np.linspace(start=0, stop=255, num=k) # returneaza intervalele

    newTrain = values_to_bins(train_images, bins)
    newTest = values_to_bins(test_images, bins)


    naive_bayes_model = MultinomialNB()
    naive_bayes_model.fit(newTrain, train_labels)
    naive_bayes_model.predict(newTest)
    return naive_bayes_model.score(newTest, test_labels)

def show_mistakes(k):
    global train_images, test_images, train_labels, test_labels
    bins = np.linspace(start=0, stop=255, num=k) # returneaza intervalele

    newTrain = values_to_bins(train_images, bins)
    newTest = values_to_bins(test_images, bins)
    # corespunzator
    # Atentie! In cazul nostru indexarea elementelor va
    # incepe de la 1, intrucat nu avem valori < 0


    naive_bayes_model = MultinomialNB()
    naive_bayes_model.fit(newTrain, train_labels)
    predictions = naive_bayes_model.predict(newTest)
    matriceConfuzie = np.zeros((10, 10))
    for i in range(len(predictions)):
        matriceConfuzie[test_labels[i]][predictions[i]] += 1
        if predictions[i] != test_labels[i]:
            image = test_images[i, :]
            image = np.reshape(image, (28, 28))
            # print(f"Imaginea {i}: predictie: {predictions[i]}. realitate: {test_labels[i]}")
            # plt.imshow(image.astype(np.uint8), cmap='gray')
            # plt.show()
    
    print("_________________________________\nMatrice confuzie:\n")
    for linie in matriceConfuzie:
        for x in linie:
            print(x, end=" ")
        print()


# calculate which value is best to use to split our intervals
maxI = 0
maxVal = 0
for i in range(3, 12, 2):
    ret = show_accuracy(i)
    if ret > maxVal:
        maxVal = ret
        maxI = i

show_mistakes(maxI)
