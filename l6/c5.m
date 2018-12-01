% Osada Krzysztof, 2018
% https://www.mathworks.com/help/matlab/ref/readtable.html
% https://www.mathworks.com/help/stats/anova2.html
% https://www.mathworks.com/help/stats/multcompare.html
% https://www.mathworks.com/help/stats/vartestn.html

clc; clear all; close all

T   = readtable('fev.csv')
z_1 = [T.z1_t1; T.z1_t2; T.z1_t3]
z_2 = [T.z2_t1; T.z2_t2; T.z2_t3]
z_3 = [T.z3_t1; T.z3_t2; T.z3_t3]

%{

Zalozenia dla dwuczynnikowej analizy wariancji (zrodlo: tresc listy zadan):

1. Populacje zrodlowe musza miec rozklad normalny.
2. Probki musza byc niezalezne.
3. Wariancje poszczegolnych populacji musza byc rowne.
4. Grupy musza byc rownoliczne.

%}

% Sprawdzenie, czy wartosci z danej grupy pochodza z rozkladu normalnego
[h_11, pval_11, swstat_11] = swtest(T.z1_t1)
[h_12, pval_12, swstat_12] = swtest(T.z1_t2)
[h_13, pval_13, swstat_13] = swtest(T.z1_t3)
[h_21, pval_21, swstat_21] = swtest(T.z2_t1)
[h_22, pval_22, swstat_22] = swtest(T.z2_t2)
[h_23, pval_23, swstat_23] = swtest(T.z2_t3)
[h_31, pval_31, swstat_31] = swtest(T.z3_t1)
[h_32, pval_32, swstat_32] = swtest(T.z3_t2)
[h_33, pval_33, swstat_33] = swtest(T.z3_t3)

if h_11 == 0 && h_12 == 0 && h_13 == 0 && h_21 == 0 && h_22 == 0 && h_23 == 0 && h_31 == 0 && h_32 == 0 && h_33 == 0

    %{
    [hv_12, pv_12] = vartest2(z_1, z_2)
    [hv_23, pv_23] = vartest2(z_2, z_3)
    [hv_13, pv_13] = vartest2(z_1, z_3)
    %}
    Tt = [T.z1_t1 T.z1_t2 T.z1_t3 T.z2_t1 T.z2_t2 T.z2_t3 T.z3_t1 T.z3_t2 T.z3_t3]
    p = vartestn(Tt)
    
    %if hv_12 == 0 && hv_23 == 0 && hv_13 == 0
    if p >= 0.05
        % Fakt: grupy sa rownoliczne
        % H01: Objetosc wymuszonego wydechu jest taka sama dla pracownikow wszystkich zakladow
        % H02: Objetosc wymuszonego oddechu nie zalezy od typu substancji toksycznej
        % H03: Wybor zakladu i typ substancji toksycznej nie maja synergicznego wplywu na objetosc wymuszonego oddechu 
        Z               = [z_1 z_2 z_3]
        [p, t, stats]   = anova2(Z, length(T.z1_t1))
        [c, m, h, nms]  = multcompare(stats)
    else
        disp('Wariancje populacji nie sa sobie rowne')
    end
else
    disp('Przynajmniej jeden z zestawow danych nie pochodzi z rozkladu normalnego')
end