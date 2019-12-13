function [zz,beta,alpha,phokm,mu,sigma,iteNum,tTotal, ...
    thetaStore, endflagStore, ...
    alphaStore, zStore, betaStore, phokmStore, ...
    muStore, sigmaStore, zzStore, probStore] = ...
    kmGibbs(PHOPER, INIalpha, INIphokm, INImu, INIsigma, I,K,M,y,minflag)
% Summary of this function goes here
%   Detailed explanation goes here

tTotal = 0;
%% Init alph pho sigma mu 
alpha = INIalpha;
phokm = INIphokm;
mu = INImu;
sigma = INIsigma;

startT0 = tic;

[zz,z,beta,~,~,~]=UpdatezbetaKM(I,K,M,y,alpha,phokm,mu,sigma);
tTotal = tTotal+toc(startT0);

prob = calProb(I, K, M, y, alpha, phokm, mu, sigma);

alphaStore = alpha;
zStore = {z};
betaStore = {beta};
phokmStore = {phokm};
muStore = {mu};
sigmaStore = {sigma};
zzStore = zz';
probStore = prob;

%% Init theta & vkm & vkaxikm
nk(1:K)=round(I/K); 
theta(1:K)=round(I/K*drchrnd(nk,1));
vkm(1:K,1:M)=round(I/K*PHOPER);
vkaxikm(1:K,1:M)=round(I/K*(1-PHOPER));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Gibbs update
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MAXINDEX=200;
oldtheta=theta+1;
tindex=1;
thetaStore = oldtheta';
endflagStore = [];
while(tindex<MAXINDEX)
    iteNum = tindex;
    disp(['**************** tindex=' int2str(tindex) '****************']);
    tic;

    startT1 = tic;
    % for-end loop is used to prevent a very small cluster
    % ---- suits to datasets with balanced clusters
    % ---- NOT suits to very unbalanced datasets (or choose minAlpha)
    %
    for k=1:K
        tmp4=k;
        tmp3=alpha(k);
        if tmp3<0.05 
            tmp5=sum(sigma,2); 
            [~,tmp2]=max(tmp5); 
            tmp6=sigma(tmp2,:); 
            [~,tmp1]=max(tmp6); 
                                
            if tmp2~=k
                theta(tmp4)=round((theta(tmp2)+theta(tmp4))./2);
                theta(tmp2)=theta(tmp4);
                nk(tmp4)=round((nk(tmp2)+nk(tmp4))./2);
                nk(tmp2)=nk(tmp4);
                vkm(tmp4,:)=round(I/K*PHOPER);
                vkaxikm(tmp4,:)=round(I/K*(1-PHOPER));
                vkm(tmp2,:)=round(I/K*PHOPER);
                vkaxikm(tmp2,:)=round(I/K*(1-PHOPER));
                phokm(tmp4,:)=PHOPER;
                phokm(tmp2,:)=1-PHOPER;
                
                sigma(tmp4,:)=sigma(tmp2,:);
                mu(tmp4,:)=mu(tmp2,:);
                mu(tmp4,tmp1)=mu(tmp4,tmp1)+1*sigma(tmp2,tmp1);
                mu(tmp2,tmp1)=mu(tmp2,tmp1)-1*sigma(tmp2,tmp1);
            else
                theta(tmp4)=round(sum(theta)./K);
                nk(tmp4)=round(sum(nk)./K);
                vkm(tmp4,:)=round(I/K*PHOPER);
                vkaxikm(tmp4,:)=round(I/K*(1-PHOPER));
                phokm(tmp4,:)=PHOPER;
                
                sigma(tmp4,:)=0.001;
                mu(tmp4,:)=rand(1,M);
            end
        end
    end
    
    % Step 1: Update alpha
    theta=theta+nk;
    alpha=drchrnd(theta,1);
    
    [~,~,~,nk,nm,nkm]=UpdatezbetaKM(I,K,M,y,alpha,phokm,mu,sigma);
    
    % Step 2: Update phokm
    for m=1:M
        for k=1:K
            vkm(k,m)=vkm(k,m)+nkm(k,m);
            vkaxikm(k,m)=vkaxikm(k,m)+nk(k)-nkm(k,m);
            phokm(k,m)=betarnd(vkm(k,m),vkaxikm(k,m));
        end
    end

    [~,z,beta,nk,nm,nkm]=UpdatezbetaKM(I,K,M,y,alpha,phokm,mu,sigma);
    
    % Step 3: Update mu & sigma
    for kk=1:K
        for mm=1:M

            tmp1 = sum(z(:,kk).*y(:,mm));
            tmp2 = sum(z(:,kk));

            if tmp2>1
                mu(kk,mm)=tmp1./tmp2;
            else
                mu(kk,mm)=rand;
            end
            

            tmp3 = sum(z(:,kk).*(y(:,mm) ...
                    - mu(kk,mm)).^2);

            if tmp2>1
                sigma(kk,mm)=max(tmp3./tmp2,0.0001);
            else
                sigma(kk,mm)=0.0001;
            end
        end
    end

    [zz,~,~,nk,nm,nkm]=UpdatezbetaKM(I,K,M,y,alpha,phokm,mu,sigma);

    tTotal = tTotal+toc(startT1);
    
    prob = calProb(I, K, M, y, alpha, phokm, mu, sigma);
    
    endflag=sum(abs(theta/sum(theta)-oldtheta/sum(oldtheta)));
    if endflag<minflag
        tindex=MAXINDEX;
    end
    oldtheta=theta;

    tindex=tindex+1;
    toc;
    thetaStore = [thetaStore, theta']; 
    endflagStore = [endflagStore; endflag];
    
    alphaStore = [alphaStore, alpha]; 
    zStore = [zStore, z];
    %betaStore = [betaStore, beta];
    if tindex <=25 || (tindex > MAXINDEX-25 && tindex <=MAXINDEX)
        betaStore = [betaStore, beta];
    end
    phokmStore = [phokmStore, phokm];
    muStore = [muStore, mu];
    sigmaStore = [sigmaStore, sigma];
    zzStore = [zzStore, zz']; 
    probStore = [probStore, prob]; 
end
