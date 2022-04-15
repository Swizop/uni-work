y_pred = [1, 1, 1, 0, 1, 0, 1, 1, 0, 0] 
y_true = [1, 0, 1, 0, 1, 0, 1, 0, 1, 0]
def accuracy_score(y_true, y_pred):
    count = 0
    for i in range(len(y_true)):
        count += 1 if y_true[i] == y_pred[i] else 0
    return count / len(y_true)

print(accuracy_score(y_true, y_pred))

def precision_recall_score(y_true, y_pred):
    tp = 0
    fp = 0
    fn = 0
    for i in range(len(y_true)):
        if y_true[i] == y_pred[i] == 1:
            tp += 1
        elif y_true[i] != y_pred[i]:
            if y_true[i] == 0:
                fp += 1
            else:
                fn += 1
    
    return (tp / (tp + fp), tp / (tp + fn))

print(precision_recall_score(y_true, y_pred))


def mse(y_true, y_pred):
    s = 0
    for i in range(len(y_true)):
        s += (y_pred[i] - y_true[i]) ** 2
    return s / len(y_true)

print(mse(y_true, y_pred))

def mae(y_true, y_pred):
    s = 0
    for i in range(len(y_true)):
        s += abs(y_pred[i] - y_true[i])
    return s / len(y_true)

print(mae(y_true, y_pred))