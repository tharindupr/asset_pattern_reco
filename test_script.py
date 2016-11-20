from sklearn.externals import joblib
from feature_extraction import *
def test(ffile):
    clf = joblib.load('Model/model.pkl')
    feature_vector=extract_features(ffile,1)
    
    return clf.predict(feature_vector)
