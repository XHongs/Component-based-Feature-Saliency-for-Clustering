# Component-based-Feature-Saliency-for-Clustering
This repository contains the code for the method presented in the paper "Component-based Feature Saliency for Clustering" ([pdf download](https://pureadmin.qub.ac.uk/ws/portalfiles/portal/180211131/HongLMZCLLZ_revision2.pdf)) | ([citation](https://ieeexplore.ieee.org/document/8809812)).


We present a novel Gaussian mixture model, which explicitly models the dependency of individual mixture components on each feature giving a new component-based feature saliency measure. Markov Chain Monte Carlo sampling is used to estimate the model and hidden variables.

### Abstract
Simultaneous feature selection and clustering is a major challenge in unsupervised learning. In particular, there has been significant research into saliency measures for features that result in good clustering. However, as datasets become larger and more complex, there is a need to adopt a finer-grained approach to saliency by measuring it in relation to a part of a model. Another issue is learning the feature saliency and advanced model parameters. We address the first by presenting a novel Gaussian mixture model, which explicitly models the dependency of individual mixture components on each feature giving a new component-based feature saliency measure. For the second, we use Markov Chain Monte Carlo sampling to estimate the model and hidden variables. Using a synthetic dataset, we demonstrate the superiority of our approach, in terms of clustering accuracy and model parameter estimation, over an approach using a model-based feature saliency with expectation maximisation. We performed an evaluation of our approach with six synthetic trajectory datasets. To demonstrate the generality of our approach, we applied it to a network traffic flow dataset for intrusion detection. Finally, we performed a comparison with state-of-the-art clustering techniques using three real-world trajectory datasets of vehicle traffic.

**URL:** https://ieeexplore.ieee.org/document/8809812

## Code Structure
*kmGibbs.m* - main function file

*runKMGibbs.m* - sample execution file (by using some synthetic trajectory datasets)

*inputData* - folder holding some samples of input datasets. In each *mat* file, variable *gt_I1* is the ground truth, *y* is the data.

*results* - folder holding the results of the implementation on the sample input datasets. In each *mat* file, variable *zz* is the clustering result, *alpha*, *phokm*, *mu* and *sigma* are the model parameters.

*trajOriginal* - folder holding the original trajectory data, from which the features were extracted to form the input datasets in the inputData folder. In each *mat* file, variable *trajs* is the original trajectory data (last two data points are excluded from input datasets). *png* files are the illustration of trajectories


## Citation
If you use this code please cite the following paper:

**Plain Text:** <br/>
X Hong, H Li, P Miller, J Zhou, L Li, D Crookes, Y Lu, X Li, H Zhou (2019) "Component-based Feature Saliency for Clustering". IEEE Transactions on Knowledge and Data Engineering, doi: 10.1109/TKDE.2019.2936847. 

**BibTex**
```
@article{hong2019TKDE,
title={Component-based Feature Saliency for Clustering},
author={Hong, Xin and Li, Hailin and Miller, Paul and Zhou, Jianjiang and Li, Ling and Crookes, Danny and Lu, Yonggang and Li, Xuelong and Zhou, Huiyu},
journal={IEEE Transactions on Knowledge and Data Engineering},
note={doi: 10.1109/TKDE.2019.2936847}
}
```
