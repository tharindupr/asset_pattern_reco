def test(ffile):
    clf = joblib.load('Model/model.pkl')
    feature_vector=extract_features(ffile,1)
    
    return model.predict(feature_vector)
