from python_speech_features import mfcc
from python_speech_features import logfbank
import scipy.io.wavfile as wav



def extract_features(wavefile,winlen):
    (rate,sig) = wav.read(wavefile)
    data=sig.T
    #checking the audio is dual channel or single
    if(len(data)==2):
        mfcc_feat = mfcc(data[0],rate,winlen,winstep=1,highfreq=300)
    else:
        mfcc_feat = mfcc(data.T,rate,winlen,winstep=1,highfreq=300)
        
    return mfcc_feat
