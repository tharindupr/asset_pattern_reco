from python_speech_features import mfcc
from python_speech_features import logfbank
import scipy.io.wavfile as wav

(rate,sig) = wav.read("Rumbles/B09h47m03s11apr2007y_RUM_367.09713___377.83901.wav")
mfcc_feat = mfcc(sig,rate,winlen=0.5)
fbank_feat = logfbank(sig,rate)


print len(mfcc_feat)
print len(mfcc_feat[0])
