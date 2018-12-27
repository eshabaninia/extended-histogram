# Extended histogram: probabilistic modelling of video content temporal evolutions
This is partial implementations of our Multidimensional Systems and Signal Processing 2017 paper for human action recognition.

## Prerequisites
The following code is based on Matlab R2014a, and libsvm-3.21. 


## Installation
1.Download and unzip datasets ('CAD60','UTKinect-Action3D','KARD' have been prepared in data folder):
https://www.dropbox.com/s/w06l38ds7zmoq6s/data.rar?dl=0

2. $ git clone https://github.com/eshabaninia/extended-histogram.git

3. Open Matlab, and run "HumanActionRecognition.m" from code directory.
You can change different parameters such as dataset , hirarchialLevels (1,2,3 or 4)and setup('lOPOCV', 'lOSOCV',…).


note: svmtrain.mex and svmpredict.mex are renamed to libsvmtrain.mex and libsvmpredict.mex

## Citation
Please cite the following paper if you use this repository in your research.
```
@article{shabaninia2017extended,
  title={Extended histogram: probabilistic modelling of video content temporal evolutions},
  author={Shabaninia, Elham and Naghsh-Nilchi, Ahmad Reza and Kasaei, Shohreh},
  journal={Multidimensional Systems and Signal Processing},
  pages={1--19},
  year={2017},
  publisher={Springer}
}


