% Osada Krzysztof, 2018

clc; clear all; close all;

rng('default')

x               = randn(1, 25)
[p, h, stats]   = signtest(x, 0)

xx              = lognrnd(2, .25, 15, 1)
y               = xx + trnd(2, 15, 1)

[p, h, stats]   = signtest(xx, y)