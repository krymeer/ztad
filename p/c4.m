% Osada Krzysztof, 2019

clc; clear all; close all;

M       = csvread('kursy_walut.csv', 1, 1)
C1      = M(:, 1)
C2      = M(:, 2)
C3      = M(:, 3)

prs12   = ranksum(C1, C2, 'tail', 'right')
prs23   = ranksum(C2, C3, 'tail', 'right')
prs13   = ranksum(C1, C3, 'tail', 'right')

if prs12 < 0.05 
    disp('Wilcoxon: hipoteza o rownosci median badanej cechy w populacjach 1. i 2. zostaje odrzucona na rzecz hipotezy alternatywnej, ze mediana badanej cechy w populacji 2. jest wieksza od mediany badanej cechy w populacji 1.')
end

if prs23 < 0.05 
    disp('Wilcoxon: hipoteza o rownosci median badanej cechy w populacjach 2. i 3. zostaje odrzucona na rzecz hipotezy alternatywnej, ze mediana badanej cechy w populacji 3. jest wieksza od mediany badanej cechy w populacji 2.')
end

if prs13 < 0.05 
    disp('Wilcoxon: hipoteza o rownosci median badanej cechy w populacjach 1. i 3. zostaje odrzucona na rzecz hipotezy alternatywnej, ze mediana badanej cechy w populacji 3. jest wieksza od mediany badanej cechy w populacji 1.')
end