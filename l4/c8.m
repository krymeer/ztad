% Osada Krzysztof, 2018
% https://www.mathworks.com/matlabcentral/mlc-downloads/downloads/submissions/25830/versions/5/previews/mwwtest.m/index.html

clc; clear all; close all;

data13 = [175.26, 177.8, 167.64, 160.02, 172.72, 177.8, 175.26, 170.18, 157.48, 160.02, 193.04, 149.86, 157.48, 157.48, 190.5, 157.48, 182.88, 160.02]
data17 = [172.72, 157.48, 170.18, 172.72, 175.26, 170.18, 154.94, 149.86, 157.48, 154.94, 175.26, 167.64, 157.48, 157.48, 154.94, 177.8]

clc

% H0: wzrost studentow z jednej grupy jest rownie duzy jak wzrost studentow z drugiej grupy
% H1: wzrost studentow z jednej grupy jest znaczaco rozny od wzrostu studentow z drugiej grupy

mwwtest(data13, data17)