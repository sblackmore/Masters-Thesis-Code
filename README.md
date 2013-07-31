Thesis Abstract:

This thesis tests whether differing acoustic signatures between amplifiers can be used to identify individual amplifier 
models in recorded performances. Utilizing a training set of impulse responses from three unique guitar amplifier models, 
data is passed through a process of convolution, deconvolution, octave band filtering, and principal component analysis.
Analysis defined the acoustic signature as a differentiating pattern between correctly and incorrectly deconvolved signals.
Two methods are presented for amplifier identification.  The first method uses a test set of guitar signals where no
information about the input signal is known and compares it against a training data set of guitar signals, and an attempt
is made to identify the amplifiers based on their acoustic signature.  The second method uses only information obtained
from each test signal to identify amplifiers.

The results of the second method showed an accurate identification of which amplifier was recorded, and this 
differentiation and classification can be performed on music signals even when the original, un-convolved signal is 
unknown.  


Notes:

The code will be unrunnable unless in possession of recorded guitar samples and impulse responses.  Code will need to be 
modified to correct array indices if new impulse response data is used. 

