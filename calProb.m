function prob = calProb(I, K, M, y, alpha, phokm, mu, sigma)

mmu = mean(y,1);
mstd = std(y,1,1);

pdfVec = zeros(I,1);

for k = 1:K
    semi_omiga = ones(I,1);
    for m = 1:M
        cpp = phokm(k,m).*normpdf(y(:,m),mu(k,m),sqrt(sigma(k,m)))+...
            (1-phokm(k,m)).*normpdf(y(:,m),mmu(m),mstd(m));
        semi_omiga = semi_omiga.*cpp;
    end
    pdfVec = pdfVec + alpha(k).*semi_omiga;
end

prob = sum(log(pdfVec+realmin));