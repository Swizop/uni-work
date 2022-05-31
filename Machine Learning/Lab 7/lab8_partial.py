from mpl_toolkits import mplot3d 
import matplotlib.pyplot as plt 

from sklearn.neural_network import MLPClassifier # importul clasei 
from sklearn import preprocessing
from sklearn.linear_model import Perceptron

import numpy as np

# ------ exercitiul 1
def plot3d_data(X, y):
    ax = plt.axes(projection='3d')
    ax.scatter3D(X[y == -1, 0], X[y == -1, 1], X[y == -1, 2],'b');
    ax.scatter3D(X[y == 1, 0], X[y == 1, 1], X[y == 1, 2],'r'); 
    plt.show()
    
def plot3d_data_and_decision_function(X, y, W, b): 
    ax = plt.axes(projection='3d')
    # create x,y
    xx, yy = np.meshgrid(range(10), range(10))
    # calculate corresponding z
    # [x, y, z] * [coef1, coef2, coef3] + b = 0
    zz = (-W[0] * xx - W[1] * yy - b) / W[2]
    ax.plot_surface(xx, yy, zz, alpha=0.5) 
    ax.scatter3D(X[y == -1, 0], X[y == -1, 1], X[y == -1, 2],'b');
    ax.scatter3D(X[y == 1, 0], X[y == 1, 1], X[y == 1, 2],'r'); 
    plt.show()
    
def train_model(model, x, y, x_test, y_test):
    model.fit(x, y)
    acc_train = model.score(x, y)
    acc_test = model.score(x_test, y_test)
    print(acc_train, acc_test)
    print(model.coef_)      # w-ul
    print(model.intercept_)     # bayes-ul
    print(model.n_iter_)
    
# incarcarea datelor de antrenare
X = np.loadtxt('./data/3d-points/x_train.txt')
y = np.loadtxt('./data/3d-points/y_train.txt', 'int') 

plot3d_data(X, y)
# incarcarea datelor de testare
X_test = np.loadtxt('./data/3d-points/x_test.txt')
y_test = np.loadtxt('./data/3d-points/y_test.txt', 'int') 

model = Perceptron(tol=1e-5, eta0=0.1)
train_model(model, X, y, X_test, y_test)