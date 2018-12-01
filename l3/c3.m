% Osada Krzysztof, 2018
% https://www.mathworks.com/help/stats/kstest2.html

clc; clear all; close all;

controlA    = [0.22, -0.87, -2.39, -1.79, 0.37, -1.54, 1.28, -0.31, -0.74, 1.72, 0.38, -0.17, -0.62, -1.10, 0.30, 0.15, 2.30, 0.19, -0.50, -0.09]
treatmentA  = [-5.13, -2.19, -2.43, -3.83, 0.50, -3.25, 4.32, 1.63, 5.18, -0.43, 7.11, 4.87, -3.10, -5.81, 3.76, 6.31, 2.58, 0.07, 5.76, 3.50]

plot_a      = cdfplot(controlA)
set(plot_a, 'linewidth', 2)
set(plot_a, 'color', [0 1 0])

hold on
plot_b      = cdfplot(treatmentA)
set(plot_b, 'linewidth', 2)
set(plot_b, 'color', [1 0 0])

title('Grupy: kontrolna oraz poddana terapii')
legend('Grupa kontrolna', 'Grupa poddana terapii', 'Location', 'best')

[h, p, ksstat] = kstest2(controlA, treatmentA)