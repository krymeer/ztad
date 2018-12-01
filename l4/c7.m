% Osada Krzysztof, 2018
% https://www.mathworks.com/matlabcentral/mlc-downloads/downloads/submissions/25830/versions/5/previews/mwwtest.m/index.html

clc; clear all; close all;

nervous     = [3, 3, 4, 5, 5]
calm        = [4, 6, 7, 9, 9]

clc

% H0: ludzie nerwowi wykonuja rownie duzo gestow co ludzie spokojni
% H1: ludzie nerwowi wykonuja znaczaca rozna liczbe gestow od liczby gestow ludzi spokojnych

mwwtest(nervous, calm)