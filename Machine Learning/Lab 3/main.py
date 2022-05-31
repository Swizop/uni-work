
import numpy as np
from collections import defaultdict
import matplotlib.pyplot as plt

train_images = np.loadtxt('data/train_images.txt') # incarcam imaginile
test_images = np.loadtxt('data/test_images.txt')
train_labels = np.loadtxt('data/train_labels.txt', 'int') # incarcam etichetele avand  tipul de date int
test_labels = np.loadtxt('data/test_labels.txt', 'int')


class KnnClassifier:
    def __init__(self, train_images, train_labels):
        self.train_images = train_images
        self.train_labels = train_labels

    def classify_image(self, test_image, num_neighbors = 3, metric = 'l2'):

        # VAR1: distante = np.sqrt(np.sum((train_images - test_image)**2, axis=1))

        # VAR 2:
        # distante = []
        # i = 0
        # for ti in self.train_images:
        #     d = None
        #     if metric == 'l1':
        #         d = np.sum(abs(test_image - ti))
        #     else:
        #         d = np.sqrt(np.sum((test_image - ti) ** 2))
        #     distante.append((d, i))
        #     i += 1
    
        # print(distante[:10])

        if metric == 'l1':
            distante = np.sum(abs(train_images - test_image), axis=1)
        elif metric == 'l2':
            distante = np.sqrt(np.sum((train_images - test_image)**2, axis=1))
        distante = np.argsort(distante)

        maxFreq = 0
        actualLabel = None
        dfdict = defaultdict(int)
        for i in range(num_neighbors):
            dfdict[self.train_labels[distante[i]]] += 1
            if dfdict[self.train_labels[distante[i]]] >= maxFreq:
                maxFreq = dfdict[self.train_labels[distante[i]]]
                actualLabel = self.train_labels[distante[i]]
        return actualLabel

classifier = KnnClassifier(train_images, train_labels)

# # ex 1
# print(classifier.classify_image(test_images[0]))
# image = np.reshape(test_images[0], (28, 28))
# plt.imshow(image.astype(np.uint8), cmap='gray')
# plt.show()

# # ex 2
# g = open("predictions.txt", 'w')
# correct = 0
# for i in range(len(test_images)):
#     predictedLabel = classifier.classify_image(test_images[i])
#     g.write(f"Predicted: {predictedLabel}. Actual: {test_labels[i]}\n")
#     if predictedLabel == test_labels[i]:
#         correct += 1
# print(f"Acuratete: {correct * 100 / len(test_images)}%")

g = open("accuracy_scores.txt", 'w')
x = np.array([1,3,5,7,9])
y = []
y1 = []

for nr in x:
    correct = 0
    correct1 = 0
    for i in range(len(test_images)):
        predictedLabel = classifier.classify_image(test_images[i], nr, 'l2')
        if predictedLabel == test_labels[i]:
            correct += 1


        predictedLabel = classifier.classify_image(test_images[i], nr, 'l1')
        if predictedLabel == test_labels[i]:
            correct1 += 1
    
    acc = correct1 * 100 / len(test_images)
    g.write(f"Acuratete pt nr vecini cu l1 - {nr}: {acc}%.")
    y1.append(acc)

    acc = correct * 100 / len(test_images)
    g.write(f"Acuratete pt nr vecini cu l2 - {nr}: {acc}%.\n")
    y.append(acc)


y = np.array(y)
y1 = np.array(y1)

plt.plot(x, y1)
plt.plot(x, y)

plt.legend(['L1', 'L2'])

plt.xlabel('nr of neighbours')
plt.ylabel('accuracy')
plt.show()
    