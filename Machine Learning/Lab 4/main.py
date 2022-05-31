import numpy as np

test_labels = np.load('data/test_labels.npy', allow_pickle=True)
train_labels = np.load('data/training_labels.npy', allow_pickle=True)
test_data = np.load('data/test_sentences.npy', allow_pickle=True)
train_data = np.load('data/training_sentences.npy', allow_pickle=True)

print(train_data)
# def normalize_data(train_data, test_data, type=None):

class BagOfWords():
    def __init__(self) -> None:
        self.vocabular = dict()
        self.lista = []

    def build_vocabulary(self, data):
        for l in data:
            for cuvant in l:
                print(cuvant)
                if cuvant not in self.vocabular:
                    self.vocabular[cuvant] = len(self.lista)
                    self.lista.append(cuvant)
        print(len(self.vocabular))

    def get_features(self, data):
        matrice = []
        for i in range(data):
            linie = []
            for j in 
bagWords = BagOfWords()
bagWords.build_vocabulary(train_data)
