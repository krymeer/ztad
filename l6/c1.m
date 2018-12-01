% Osada Krzysztof, 2018
% https://www.mathworks.com/help/stats/anova1.html
% https://www.mathworks.com/help/stats/vartest2.html
% https://www.mathworks.com/matlabcentral/fileexchange/13964-shapiro-wilk-and-shapiro-francia-normality-tests

clc; clear all; close all

load('anova_data.mat')

g_1 = koala(:, 1)
g_2 = koala(:, 2)
g_3 = koala(:, 3)

% Sprawdzenie, czy dane w poszczegolnych grupach pochodza z rozkladu normalnego
[h_1, pval_1, swstat_1] = swtest(g_1)
[h_2, pval_2, swstat_2] = swtest(g_2)
[h_3, pval_3, swstat_3] = swtest(g_3)


if h_1 == 0 && h_2 == 0 && h_3 == 0
    % Sprawdzenie, czy wariancje wszystkich grup sa soie rowne
    [hv_12, pv_12] = vartest2(g_1, g_2)
    [hv_23, pv_23] = vartest2(g_2, g_3)
    [hv_13, pv_13] = vartest2(g_1, g_3)

    if hv_12 == 0 && hv_23 == 0 && hv_13 == 0
        %{
        l       = length(g_1)
        X       = [g_1; g_2; g_3]
        group   = [ones(l, 1); ones(l, 1) * 2; ones(l, 1) * 3]
        p       = anova1(X, group)
        %}

        % H0: probki zawarte we wszystkich grupach pochodza z populacji o jednakowych wartosciach srednich
        % H1: dla przynajmniej jednej probki srednia z niej jest znaczaco inna od srednich z pozostalych probek
        p = anova1(koala)
    else
        disp('Wariancje w poszczegolnych grupach nie sa sobie rowne')
    end
else
    disp('Przynajmniej jeden z zestawow danych nie pochodzi z rozkladu normalnego') 
end

%{

p-value for the F-test, returned as a scalar value. p-value is the probability that the F-statistic can take a value larger than the computed test-statistic value. anova1 tests the null hypothesis that all group means are equal to each other against the alternative hypothesis that at least one group mean is different from the others. The function derives the p-value from the cdf of the F-distribution.

Ap-value that is smaller than the significance level indicates that at least one of the sample means is significantly different from the others. Common significance levels are 0.05 or 0.01.

%}