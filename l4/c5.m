% Osada Krzysztof, 2018
% https://www.mathworks.com/help/stats/ttest.html

clc; clear all; close all;

data13  = [175.26, 177.8, 167.64000000000001, 160.02, 172.72, 177.8, 175.26, 170.18, 157.48, 160.02, 193.04, 149.86, 157.48, 157.48, 190.5, 157.48, 182.88, 160.02]
m       = 169.05

clc

%qqplot(data13)
%ylabel('Wzrost')
%xlabel('Kwantyle normalne')
%title('Wartosci wzrostu studentow w pewnej grupie')

[h, pval, swstats] = swtest(data13)

if h == 1
    disp('Uwaga: zestaw danych nie pochodzi z rozkladu normalnego')
end

% H1: srednia jest rozna od m
[h, p, ci, stats] = ttest(data13, m)

% H1': srednia jest mniejsza od m
[h, p, ci, stats] = ttest(data13, m, 'Tail', 'left')