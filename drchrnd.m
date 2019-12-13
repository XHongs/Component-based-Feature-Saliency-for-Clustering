function r = drchrnd(a,n)
% take a sample from a dirichlet distribution
% ref: https://www.douban.com/note/45584915/

% a=[1 1 1]; n=1;

p = length(a);
r = gamrnd(repmat(a,n,1),1,n,p);
r = r ./ repmat(sum(r,2),1,p);
r=r.';

end

