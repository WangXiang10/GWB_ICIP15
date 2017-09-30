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

%% 
psalSuffix = '_RC.png';             % Suffix name of your saliency maps
method = 'RC';                      % Name of you method

Src = 'Src';                        % Source image
SalMaps = 'SalMaps';                % Existing saliency map as prior distribution
Result = 'Result';                  % Path for saving results
srcSuffix = '.jpg';
files = dir(fullfile(Src, strcat('*', srcSuffix)));            
for k = 1: length(files)
    disp(k)
    srcName = [Src, '\', files(k).name];
    
    % Calculate Probabilities in the Bayesian Formulation
    [PrI_sal, PrI_bg, PrO_sal, PrO_bg, In_Ind, Out_Ind] = CalGeoProb(srcName);
    [~, noSuffixName, ~] = fileparts(srcName);
    
    resMethod = [Result, '\', method];
    if ~exist(resMethod, 'dir')
        mkdir(resMethod);
    end
    psalName = strrep(files(k).name, srcSuffix, psalSuffix);
    psal = imread([SalMaps, '\', psalName]);
    % Calculate improved salienct map using GWB
    salmap = CalImprovedMap(psal, PrI_sal, PrI_bg, PrO_sal, PrO_bg, In_Ind, Out_Ind);
    
    % Smooth saliency map using graph-based segmentation
    salmapSm = smoothSalMaps(srcName, salmap);
    salname = [resMethod, '\', noSuffixName, '_', method, '_GWB.png'];
    imwrite(salmapSm, salname)
end
