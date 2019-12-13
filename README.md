# Component-based-Feature-Saliency-for-Clustering
This repository contains the code for the method presented in the paper "Component-based Feature Saliency for Clustering" ([pdf download](https://pureadmin.qub.ac.uk/ws/portalfiles/portal/180211131/HongLMZCLLZ_revision2.pdf)) | ([citation](https://ieeexplore.ieee.org/document/8809812)).


We present a novel Gaussian mixture model, which explicitly models the dependency of individual mixture components on each feature giving a new component-based feature saliency measure. Markov Chain Monte Carlo sampling is used to estimate the model and hidden variables.


## Code
*kmGibbs.m* - main function file

*runKMGibbs.m* - sample execution file (by using some synthetic trajectory datasets)

*inputData* - folder holding some samples of input datasets. In each *mat* file, variable *gt_I1* is the ground truth, *y* is the data.

*results* - folder holding the results of the implementation on the sample input datasets. In each *mat* file, variable *zz* is the clustering result, *alpha*, *phokm*, *mu* and *sigma* are the model parameters.

*trajOriginal* - folder holding the original trajectory data, from which the features were extracted to form the input datasets in the inputData folder. In each *mat* file, variable *trajs* is the original trajectory data (last two data points are excluded from input datasets). *png* files are the illustration of trajectories


## Citation
If you use this code please cite the following paper:

```
@article{hong2019KDE,
title={Component-based Feature Saliency for Clustering},
author={Hong, Xin and Li, Hailin and Miller, Paul and Zhou, Jianjiang and Li, Ling and Crookes, Danny and Lu, Yonggang and Li, Xuelong and Zhou, Huiyu},
journal={IEEE Transactions on Knowledge and Data Engineering},
note={doi: 10.1109/TKDE.2019.2936847}
}
```
