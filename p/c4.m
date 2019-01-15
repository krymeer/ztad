

%{

pkw     = kruskalwallis(M, [], 'off')
prs12   = ranksum(C1, C2)
prs23   = ranksum(C2, C3)
prs13   = ranksum(C1, C3)

if pkw < 0.05
    disp('Kruskal-Wallis: dane nie pochodza z tego samego rozkladu')
end

if prs12 < 0.05 || prs13 < 0.05 || prs23 < 0.05
    disp('Wilcoxon: populacje nie maja rownych median');
end
%}