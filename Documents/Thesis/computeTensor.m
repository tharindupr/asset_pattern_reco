% Copyright (c) 2016, Matthias Zeppelzauer
% 
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
% 1. Redistributions of source code must retain the above copyright
%    notice, this list of conditions and the following disclaimer.
% 2. Redistributions in binary form must reproduce the above copyright
%    notice, this list of conditions and the following disclaimer in the
%    documentation and/or other materials provided with the distribution.
% 3. All advertising materials mentioning features or use of this software
%    must display the following acknowledgement:
%    This product includes software developed by the <organization>.
% 4. Neither the name of the <organization> nor the
%    names of its contributors may be used to endorse or promote products
%    derived from this software without specific prior written permission.
% 
% THIS SOFTWARE IS PROVIDED BY MATTHIAS ZEPPELZAUER ''AS IS'' AND ANY
% EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
% WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL MATTHIAS ZEPPELZAUER BE LIABLE FOR ANY
% DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
% (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
% LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
% ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
% (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
% SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
% 
% 
% Perform sound enhancement by the application of the 2D tensor on the spectrogram
%
% Inputs: - an audio spectrogram
% 		  - the size of a 2-dimensional Gaussian filter, e.g. [15 20], to smooth the output
%
% Outputs: - l1, l2: the two eigenvalues for each pixel in the spectrogram
%		   - coherence: the coherence computed from the eigenvalues  
%		   - discriminant: the discriminant computed from the eigenvalues 
%		   - sumEV: the sum of the eigenvalues 
%		   - prodEV: the product of the eigenvalues 
%		   - coherence: the coherence computed from the eigenvalues  	
%		   - Gx, Gy: the temporal and spatial gradient from the spectrogram (for each pixel) 		
%
% If you use this code, please cite this paper:
% 	Zeppelzauer, M., Stöger, A. S., & Breiteneder, C. (2013, October). 
% 	Acoustic detection of elephant presence in noisy environments. 
% 	In Proceedings of the 2nd ACM international workshop on Multimedia 
% 	analysis for ecological data (pp. 3-8). ACM.


function [l1, l2, coherence, discriminant, sumEV, prodEV, Gx, Gy] = computeTensor(spec,gaussWinSize)

[Ix, Iy]=gradient(spec);

%get tensor
Ix2 = Ix.*Ix;
Iy2 = Iy.*Iy;
Ixy = Ix.*Iy;



filt = fspecial('gaussian',gaussWinSize,sqrt(prod(gaussWinSize))/4); 
%figure; mesh(filt)
Gx = Ix;
Gy = Iy;
Gx = conv2(Ix,filt,'same');
Gy = conv2(Iy,filt,'same');



%filter tensor by gaussian
Ix2 = conv2(Ix2,filt,'same');
Iy2 = conv2(Iy2,filt,'same');
Ixy = conv2(Ixy,filt,'same');

%compute eigenvalues
l1 = 0.5*((Ix2 + Iy2) + sqrt( (Ix2-Iy2).^2 + 4*Ixy.^2)); 
l2 = 0.5*((Ix2 + Iy2) - sqrt( (Ix2-Iy2).^2 + 4*Ixy.^2)); 

discriminant = Ix2 .* Iy2 - Ixy.^2 + (Ix2 + Iy2).^2; %Formula: det(T)+trace(T)^2
sumEV = Ix2 + Iy2; %indicator for edges and cordners
prodEV = Ix2 .* Iy2 - Ixy.^2; %indicator for edges and cordners
coherence = ((l1-l2)./(l1+l2)).^2;

