%% demo for GWB
% @inproceedings{icip15gwb,
%   author    = {Wang, Xiang and Ma, Huimin and Chen, Xiaozhi},
%   title     = {Geodesic Weighted Bayesian Model For Salient Object Detection},
%   booktitle = {IEEE ICIP},
%   year      = {2015},
% }
%%
clear all; close all;clc;
addpath(genpath('Funcs'));

Result = 'Result';                      % Path for saving results
if ~exist(Result, 'dir')
    mkdir(Result);
end
srcName = 'Src\2007_007948.jpg';             % Source image
psalName = 'SalMaps\2007_007948_RC.png';     % Existing saliency map as prior distribution
psal = imread(psalName);

% Calculate Probabilities in the Bayesian Formulation
[PrI_sal, PrI_bg, PrO_sal, PrO_bg, In_Ind, Out_Ind] = CalGeoProb(srcName);

% Calculate improved salienct map using GWB
salmap = CalImprovedMap(psal, PrI_sal, PrI_bg, PrO_sal, PrO_bg, In_Ind, Out_Ind);
% Smooth saliency map using graph-based segmentation
salmapSm = smoothSalMaps(srcName, salmap);
% Save improved saliency map
method = 'RC';                          % Name of the existing model
[~, noSuffixName, ~] = fileparts(srcName);
salname = [Result, '\', noSuffixName, '_', method, '_GWB.png'];
imwrite(salmapSm, salname);
% Compare saliency maps
figure(1);
subplot(1,2,1);
imshow(psal);
title(method)
subplot(1,2,2);
imshow(salmapSm)
title('Improved by GWB')
