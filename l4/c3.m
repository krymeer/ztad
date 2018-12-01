% Osada Krzysztof, 2018

clc; clear all; close all;

late20      = [6, 7, 10, 9]
early30     = [5, 6, 2, 3]

% Czy dane pochodza z rozkladu normalnego?
[hl, pvall, swstatl] = swtest(late20)
[he, pvale, swstate] = swtest(early30)

clc

if hl == 0 && he == 0
    % H0: ludzie sa tak samo dowcipni niezaleznie od wieku
    % H1: ludzie przed 30 sa bardziej dowcipni od ludzi po 30
    [h, pval, ci, stats] = ttest2(late20, early30, 'Tail', 'Right')
else
    disp('Przynajmniej jeden z zestawow danych nie pochodzi z rozkladu normalnego')
end