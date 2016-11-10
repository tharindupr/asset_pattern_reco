import numpy as np
from scipy.io import wavfile
import math


#this work only for 16bit wave format

def getAngle(fi):
    fs, data = wavfile.read(fi)
    data=data.astype('float64')
    data=data.T/32767
    s1=data[0]
    s2=data[1]
    limit=len(data[0])
    fs = 44100
    d = 3 #distance between two microphones
    vs=335.0
    start_window = 1
    end_window = 10000
    window = 10000
    total = 0
    arr=[]
    while(end_window<limit):
        s1=data[0][start_window:end_window]
        s2=data[1][start_window:end_window]
        xcor=np.correlate(s1,s2,'full')
        m=max(xcor)
        #print(xcor)
        im=np.argmax(xcor)
        start_window = start_window + window
        end_window = end_window + window
        deference = abs(im - window)
        #print deference
        #break
        #print(deference*vs/fs/d)
        ang = deference*vs/fs/d
        if(ang<=1):
            angle=np.arcsin(ang)
            arr.append(math.degrees(angle))
    plt.hist(arr)
    plt.show()

    return(arr)


import matplotlib.pyplot as plt
