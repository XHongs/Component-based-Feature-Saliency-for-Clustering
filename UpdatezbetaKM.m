function [zz,z,beta,nk,nm,nkm]=UpdatezbetaKM(I,K,M,y,...
    alpha,phokm,mu,sigma)
% 
%   This function updates (zz, z, beta, nk, nm, nkm), by using
%       the given model parameters, (alpha, phokm, mu, sigma)
%
%   

%% Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
zz(1:I)=0;
z(1:I,1:K)=0;
beta(1:I,1:K,1:M)=0;
nk(1:K)=0;
nm(1:M)=0;
nkm(1:K,1:M)=0;

a(1:I,1:K,1:M)=0;
b(1:I,1:K,1:M)=0;
c(1:I,1:K,1:M)=0;
omiga(1:I,1:K)=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Update z,beta
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mmu = mean(y,1);
mstd = std(y,1,1);
for k=1:K
    for m=1:M
        a(:,k,m) = phokm(k,m).*normpdf(y(:,m),mu(k,m),sqrt(sigma(k,m)));
        b(:,k,m)=(1-phokm(k,m)).*normpdf(y(:,m),mmu(m),mstd(m));
        c(:,k,m)=a(:,k,m)+b(:,k,m);
    end
end

for ni=1:I
    sumomiga=0;
    for k=1:K
        tmp=1;
        for m=1:M
            tmp=tmp.*c(ni,k,m);
        end
        omiga(ni,k)=alpha(k).*tmp;
        sumomiga=sumomiga+omiga(ni,k);
    end
    omiga(ni,:)=omiga(ni,:)./sumomiga;
    [~,zz(ni)]=max(omiga(ni,:));
    z(ni,zz(ni))=1;
    
    for k=1:K
        if z(ni,k)==1
            for m=1:M
                if a(ni,k,m)<b(ni,k,m)
                    beta(ni,k,m)=0;
                else
                    beta(ni,k,m)=1;
                end
                if c(ni,k,m)==0
                    beta(ni,k,m)=round(rand);
                    disp(['c==0' ' ni=' int2str(ni) ...
                        ' k=' int2str(k) ' m=' int2str(m)]);
                end
            end            
        else
            beta(ni,k,:)=0;
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Update nk,nkm,nm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nk(:)=0;
for k=1:K
    nk(k)=sum(z(:,k));
end


nm(:)=0;
nkm(:,:)=0;
for m=1:M
    for k=1:K
        nm(m) = nm(m) + sum(z(:,k).*beta(:,k,m));
        nkm(k,m)=nkm(k,m)+sum(z(:,k).*beta(:,k,m));
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
