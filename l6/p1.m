% Osada Krzysztof, 2018
% https://www.mathworks.com/help/stats/signtest.html

clc; clear all; close all

X = meshgrid(1:5)
X = X + normrnd(0, 1, 5)
p = anova1(X)

%{
Source      SS      df     MS       F     Prob>F
------------------------------------------------
Columns   53.7238    4   13.4309   6.05   0.0023
Error     44.408    20    2.2204                
Total     98.1318   24


Source – zrodlo wariancji:
- Columns   – miedzygrupowa (roznice pomiedzy srednimi z kolumn);
- Error     – wewnatrzgrupowa (miedzy danymi w poszczegolnych kolumnach a odpowiadajacymi im srednimi)
- Total     – laczna

df      – stopnie swobody
MS      – blad sredniokwadratowy (SS/df)
F       – F-statystyka, iloraz bledow sredniokwadratowych
Prob>F  – prawdopodobienstwo, ze statystyka testowa moze przyjac wartosc wieksza od obliczonej
          (mala wartosc wskazuje na to, ze roznice miedzy srednimi z kolumn sa znaczace)
%}