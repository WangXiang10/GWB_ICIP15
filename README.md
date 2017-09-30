# Geodesic Weighted Bayesian Model For Salient Object Detection (GWB) v2
Copyright 2015 Xiang Wang (wangxiang14@mails.tsinghua.edu.cn)
## Introduction
***
 This is a accelerated version of the original code:
 http://3dimage.ee.tsinghua.edu.cn/files/XiangWang/gwb/GWB_ICIP15_code.zip
 The code can be further speeded up by using mexopencv to compute the histogram.
 https://github.com/kyamagu/mexopencv
***

GWB can be used to improve the quality of most existing salient object detection models with little computation overhead.
If you use GWB, please cite the following paper:

    @inproceedings{icip15gwb,
      author    = {Xiang Wang and Huimin Ma and Xiaozhi Chen},
      title     = {Geodesic Weighted Bayesian Model For Salient Object Detection},
      booktitle = {IEEE ICIP},
      year      = {2015},
    }


## Demo for GWB
GWB can be integrated into any existing salient object detection models. 

Run 'demo.m' which using an image as source image and a saliency map as prior distribution, 

this demo will generate a improved saliency map using GWB, and save it in the Result path.

A comparison will also be shown.


## Improve your own saliency maps 
To apply GWB to your own saliency maps , follow these steps:

1) Edit 'demo_Improve.m' to add information of your own saliency map. Including the suffix of your maps' name (psalSuffix) and the name of your method (method);
2) Put your saliency maps to the path SalMaps or modify it
3) Put your source images to the path Src or modify it
4) Run 'demo_Improve.m'.


## Acknowledgements
We use or modify: 

K. van de Sande's code for colorspaces conversion, 

Wangjiang Zhu's code for calculating geodesic distance

Yulin Xie's code for calculating probabilities

P. Felzenszwalb's code for graph-based segmentation. 
