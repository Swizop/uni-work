from sklearn.neural_network import MLPClassifier
from sklearn import preprocessing
import numpy as np

# incarcarea datelor de antrenare
X = np.loadtxt('./data/MNIST/train_images.txt')
y = np.loadtxt('./data/MNIST/train_labels.txt', 'int') 

# plot3d_data(X, y)
# incarcarea datelor de testare
X_test = np.loadtxt('./data/MNIST/test_images.txt')
y_test = np.loadtxt('./data/MNIST/test_labels.txt', 'int') 

def train_model(model, x, y, x_test, y_test):
    model.fit(x, y)
    acc_train = model.score(x, y)
    acc_test = model.score(x_test, y_test)
    print(acc_train, acc_test)
    print(model.n_iter_)


scaler = preprocessing.StandardScaler()
scaler.fit(X)
scaled_X = scaler.transform(X)
scaled_Xtest = scaler.transform(X_test)

model = MLPClassifier(activation="relu", hidden_layer_sizes=(100, 100), learning_rate_init=0.01, momentum=0.9, max_iter=2000,alpha=0.005)
train_model(model, scaled_X, y, scaled_Xtest, y_test)
