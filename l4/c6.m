% Osada Krzysztof, 2018
% https://www.mathworks.com/help/stats/ttest.html

clc; clear all; close all;

data17  = [172.72, 157.48, 170.18, 172.72, 175.26, 170.18, 154.94, 149.86, 157.48, 154.94, 175.26, 167.64000000000001, 157.48, 157.48, 154.94, 177.8]
m       = 164.1475

clc

%qqplot(data17)
%ylabel('Wzrost')
%xlabel('Kwantyle normalne')
%title('Wartosci wzrostu studentow w pewnej grupie')

[h, pval, swstats] = swtest(data17)

if h == 1
    disp('Uwaga: zestaw danych nie pochodzi z rozkladu normalnego')
end

% H1: srednia jest rozna od m
[h, p, ci, stats] = ttest(data17, m)

% H1': srednia jest wieksza od m
[h, p, ci, stats] = ttest(data17, m, 'Tail', 'left')