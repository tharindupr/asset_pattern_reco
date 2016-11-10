from sklearn import svm
X = [[0, 0,1,4], [1, 1,2,3],[1,3,1,5],[-1,-2,3,4]]
y = [0, 1,1,0]
clf = svm.SVC()
clf.fit(X, y)
print clf.predict([[0, 0,0,1]])
