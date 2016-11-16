from feature_extraction import *
from sklearn import svm
from os import listdir,getcwd

negative_files=listdir('./Negative')
positive_files=listdir('./Positive')

postive_features=[]
negative_features=[]
y=[]
for fil in positive_files:
    feature_vector=extract_features('Positive/'+fil,1)
    for f in feature_vector:
        postive_features.append(f)
        y.append(1)
for fil in negative_files:
    feature_vector=extract_features('Negative/'+fil,1)
    for f in feature_vector:
        negative_features.append(f)
        y.append(0)

x=postive_features+negative_features
clf = svm.SVC()
clf.fit(x, y)


#Saving the model
from sklearn.externals import joblib
joblib.dump(clf, 'Model/model.pkl')




    
            
#X = [[0, 0,1,4], [1, 1,2,3],[1,3,1,5],[-1,-2,3,4]]
#y = [0, 1,1,0]
#clf = svm.SVC()
#clf.fit(X, y)
#print clf.predict([[0, 0,0,1]])
