% Osada Krzysztof, 2018
% https://www.mathworks.com/help/stats/signtest.html

clc; clear all; close all

w_1 = [88, 69, 86, 59, 57, 82, 94, 93, 64, 91, 86, 59, 91, 60, 57, 92, 70, 88, 70, 85]
w_2 = [73, 68, 75, 54, 53, 84, 84, 86, 66, 84, 78, 58, 91, 57, 59, 88, 71, 84, 64, 85]

% H0: mediana jest rowna 0
% H1: mediana jest wieksza od 0 (waga wiekszosci kobiet spadla)

clc

[p, h, stats] = signtest(w_1, w_2, 'Tail', 'right')

% Zgodnie z powyzsza dokumentacja mediana jest wyznaczana dla roznicy x-y (para (x, y)) 

% -----------------

%{
subplot(2, 1, 1)
qqplot(w_1)
title('Przed dieta odchudzajaca')
xlabel('Kwantyle normalne')
ylabel('Waga kobiet')

subplot(2, 1, 2)
qqplot(w_2)
title('Po diecie odchudzajacej')
xlabel('Kwantyle normalne')
ylabel('Waga kobiet')

suptitle('Badanie ciezaru ciala kobiet')
%}

%{
plot_1 = plot(w_1, '-s')
hold on

plot_2 = plot(w_2, '-s')

set(plot_1, 'linewidth', 2)
set(plot_2, 'linewidth', 2)

title('Badanie zmiany ciezaru ciala kobiet pod wplywem diety odchudzajacej')

legend('Przed dieta', 'Po diecie', 'Location', 'best')
ylabel('Waga kobiety')
xlabel('Indeks porzadkowy kobiety')
%}