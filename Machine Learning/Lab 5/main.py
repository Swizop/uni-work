# curs 4: la regresie precision, recall nu prea pot fi folosite (prezis 200.1 pentru 200 real tot e bine)

# regresie -> folosim loss (pierdere) ca sa masuram acuratetea. variante de loss:
    # MSE = suma de la i la n din (y real - y pred) ^ 2
    # MAE  = sum de la i la n din modul(y real - y pred)

# regresia liniara
    # overfitting 
    # underfitting = prea pus pe training set
    # intotdeauna regresia are forma asta f(x) = x * w + b
    # loss = MSE

# REGRESIA Ridge: loss2 = (y - ypred) ^ 2 + alfa * ||w||2  (norma L2 lui w)     --> w(i) se fac foarte mici dar nu ajung exact 0 niciodata
# regresia Lasso -> loss3 = loss1 + alfa * ||w||1      ! --> aici w urile pot ajunge egale cu 0
        # alfa trb gasit de noi

# dc am folosi astea 2 regresii si nu direct MSE clasic? prin astea, reducem si w-urile si sunt sanse mult mai mici
        # sa ajungi la overfitting


# GRADIENT DESCEND: pot sa aflu un minim local sau global al unei functii

# DIFERENTA DINTRE RIDGE SI LASSO:
# lasso poate duce w la 0 deci poate face unele feature-uri inutile.
    # ex: x1 = (3, 1, 9) ; x2 = (9, 8, 4); w = (3, 3, 0)        => cand faci x1 * w si x2 * w, feature-ul 3 va fi 0


# CROSS VALIDATION: ai doar train data; si imparti intr-un numar de pachete; folosesti o parte ca train si o parte ca test
        # ------> KFOLD se numeste. sklearn

# ONE HOT ENCODER pt normalizarea unei coloane cu string-uri pe ea


# LINEAR
import numpy as np
from sklearn.utils import shuffle
from sklearn.metrics import mean_squared_error, mean_absolute_error 
from sklearn import preprocessing
from sklearn.linear_model import LinearRegression, Ridge, Lasso

# load training data
# training_data = np.load('data/training_data.npy')    
# prices = np.load('data/prices.npy')  
  
# # print the first 4 samples
# print('The first 4 samples are:\n ', training_data[:4])
# print('The first 4 prices are:\n ', prices[:4])

# training_data, prices = shuffle(training_data, prices, random_state=0)

# # normalizare 
# def normalize_data(training, testing=None):
#     scaler = preprocessing.StandardScaler() 
#     scaler.fit(training)    
#     scaled_x_train = scaler.transform(training) 
#     if testing is None:
#         return scaled_x_train
#     scaled_x_test = scaler.transform(testing) 
#     return scaled_x_train, scaled_x_test

# print(len(training_data))
# num_samples_fold = len(training_data) // 3
# training_data_1, prices_1 = training_data[:num_samples_fold], prices[:num_samples_fold]
# training_data_2, prices_2 = training_data[num_samples_fold: 2 * num_samples_fold], prices[num_samples_fold: 2 * num_samples_fold]
# training_data_3, prices_3 = training_data[2 * num_samples_fold:], prices[2 * num_samples_fold:]
# def normalizare_train_model(model, training_samples, labels, testing_data, testing_labels): 
#     training_samples, testing_data = normalize_data(training_samples, testing_data) 
#     model.fit(training_samples, labels) 
#     return mean_absolute_error(testing_labels, model.predict(testing_data)), mean_squared_error(testing_labels, model.predict(testing_data))


# model = LinearRegression()
# mae_1, mse_1 = normalizare_train_model(model, np.concatenate((training_data_1, training_data_2)), np.concatenate((prices_1, prices_2)), training_data_3, prices_3)
# mae_2, mse_2 = normalizare_train_model(model, np.concatenate((training_data_1, training_data_3)), np.concatenate((prices_1, prices_3)), training_data_2, prices_2)
# mae_3, mse_3 = normalizare_train_model(model, np.concatenate((training_data_3, training_data_2)), np.concatenate((prices_3, prices_2)), training_data_1, prices_1)

# print('Mean MAE', (mae_1 + mae_2 + mae_3) / 3)
# print('Mean MSE', (mse_1 + mse_2 + mse_3) / 3)



# RIDGE REGRESSION
# training_data = np.load('data/training_data.npy')    
# prices = np.load('data/prices.npy')  
  
# # print the first 4 samples
# print('The first 4 samples are:\n ', training_data[:4])
# print('The first 4 prices are:\n ', prices[:4])

# training_data, prices = shuffle(training_data, prices, random_state=0)

# # normalizare 
# def normalize_data(training, testing=None):
#     scaler = preprocessing.StandardScaler() 
#     scaler.fit(training)    
#     scaled_x_train = scaler.transform(training) 
#     if testing is None:
#         return scaled_x_train
#     scaled_x_test = scaler.transform(testing) 
#     return scaled_x_train, scaled_x_test
    
# print(len(training_data))
# num_samples_fold = len(training_data) // 3
# training_data_1, prices_1 = training_data[:num_samples_fold], prices[:num_samples_fold]
# training_data_2, prices_2 = training_data[num_samples_fold: 2 * num_samples_fold], prices[num_samples_fold: 2 * num_samples_fold]
# training_data_3, prices_3 = training_data[2 * num_samples_fold:], prices[2 * num_samples_fold:]
# def normalizare_train_model(model, training_samples, labels, testing_data, testing_labels): 
#     training_samples, testing_data = normalize_data(training_samples, testing_data) 
#     model.fit(training_samples, labels) 
#     return mean_absolute_error(testing_labels, model.predict(testing_data)), mean_squared_error(testing_labels, model.predict(testing_data))


# for alfa in [1, 10, 100, 100]:      # HIPERPARAMETRIZARE
#     print(F"___________________________________\nALFA: {alfa}")
#     model = Ridge(alpha=alfa)
#     mae_1, mse_1 = normalizare_train_model(model, np.concatenate((training_data_1, training_data_2)), np.concatenate((prices_1, prices_2)), training_data_3, prices_3)
#     mae_2, mse_2 = normalizare_train_model(model, np.concatenate((training_data_1, training_data_3)), np.concatenate((prices_1, prices_3)), training_data_2, prices_2)
#     mae_3, mse_3 = normalizare_train_model(model, np.concatenate((training_data_3, training_data_2)), np.concatenate((prices_3, prices_2)), training_data_1, prices_1)

#     print('Mean MAE', (mae_1 + mae_2 + mae_3) / 3)
#     print('Mean MSE', (mse_1 + mse_2 + mse_3) / 3)


# EX 3
training_data = np.load('data/training_data.npy')    
prices = np.load('data/prices.npy')  
  
# print the first 4 samples
print('The first 4 samples are:\n ', training_data[:4])
print('The first 4 prices are:\n ', prices[:4])

training_data, prices = shuffle(training_data, prices, random_state=0)

# normalizare 
def normalize_data(training, testing=None):
    scaler = preprocessing.StandardScaler() 
    scaler.fit(training)    
    scaled_x_train = scaler.transform(training) 
    if testing is None:
        return scaled_x_train
    scaled_x_test = scaler.transform(testing) 
    return scaled_x_train, scaled_x_test
    
print(len(training_data))
num_samples_fold = len(training_data) // 3
training_data_1, prices_1 = training_data[:num_samples_fold], prices[:num_samples_fold]
training_data_2, prices_2 = training_data[num_samples_fold: 2 * num_samples_fold], prices[num_samples_fold: 2 * num_samples_fold]
training_data_3, prices_3 = training_data[2 * num_samples_fold:], prices[2 * num_samples_fold:]
def normalizare_train_model(model, training_samples, labels, testing_data, testing_labels): 
    training_samples, testing_data = normalize_data(training_samples, testing_data) 
    model.fit(training_samples, labels) 
    return mean_absolute_error(testing_labels, model.predict(testing_data)), mean_squared_error(testing_labels, model.predict(testing_data))

model = Ridge(alpha=100)
x_train = normalize_data(training_data)
model.fit(x_train, prices)      # a antrenat x train si am obtinut w si bias (b)
print(model.coef_)      # ne da w-ul
print(model.intercept_)     # ne da b-ul
# mae_1, mse_1 = normalizare_train_model(model, np.concatenate((training_data_1, training_data_2)), np.concatenate((prices_1, prices_2)), training_data_3, prices_3)
# mae_2, mse_2 = normalizare_train_model(model, np.concatenate((training_data_1, training_data_3)), np.concatenate((prices_1, prices_3)), training_data_2, prices_2)
# mae_3, mse_3 = normalizare_train_model(model, np.concatenate((training_data_3, training_data_2)), np.concatenate((prices_3, prices_2)), training_data_1, prices_1)

# print('Mean MAE', (mae_1 + mae_2 + mae_3) / 3)
# print('Mean MSE', (mse_1 + mse_2 + mse_3) / 3)