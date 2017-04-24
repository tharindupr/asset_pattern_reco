from sklearn.externals import joblib
from feature_extraction import *
from os import listdir

def test(ffile):
    clf = joblib.load('Model/model.pkl')
    feature_vector=extract_features(ffile,1)
    
    return clf.predict(feature_vector)


positive=listdir('Testing/Positive')
negative=listdir('Testing/Negative')


print "\n\nTesting positive set\n\n"
for i in positive:
    arr= test('Testing/Positive/'+i)
    print ""+i[-9:]+ " : "+ str(arr)



print "\n\nTesting Negative set\n\n"
for i in negative:
    arr= test('Testing/Negative/'+i)
    print ""+i[-9:]+ " : "+ str(arr)
