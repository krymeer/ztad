mu = 3
sigma = 7
n = normrnd(3, 7, 50, 1)
subplot(1, 2, 1)
hist(n)
title('Normal distribution')
pd = makedist('Normal','mu',mu,'sigma',sigma);
x = -25:.1:25
cdfn = cdf(pd, x)
subplot(1, 2, 2)
plot(x, cdfn, 'LineWidth', 2)
title('Cumulative distribution function')