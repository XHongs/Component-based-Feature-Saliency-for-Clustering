%%
clear; clc;

pathInput = './inputData/';
pathOutput = './results/';
fileList = {'c05o02i01.mat';'c06o02i01.mat';'c07o02i01.mat';...
    'c08o02i01.mat';'c09o02i01.mat';'c10o02i01.mat';};

%% 
fileIdx = 5;

filename = fileList{fileIdx};

load([pathInput filename],'K','y')

M = size(y,2);
I = size(y,1);
PHOPER=0.5;

kINIalpha(1:K,1)=1./K;
kINIphokm(1:K,1:M)=PHOPER;
kINImu=y(randperm(I,K),:);
kINIsigma(1:K,1:M)=0.001;
minflag=0.0001; 

[zz,beta,alpha,phokm,mu,sigma,iteTrain,timeTrain, ...
            thetaStore, endflagStore, ...
            alphaStore, zStore, betaStore, phokmStore, ...
            muStore, sigmaStore, zzStore, probStore] = ...
            kmGibbs(PHOPER, kINIalpha, kINIphokm, ...
                kINImu, kINIsigma,I,K,M,y,minflag);

save([pathOutput filename], ...
            'K', 'y', 'M', 'I', ...
            'zz', 'beta', 'alpha', 'phokm', 'mu', 'sigma',...
            'iteTrain', 'timeTrain', 'thetaStore', 'endflagStore',...
            'alphaStore', 'zStore', 'betaStore', 'phokmStore',...
            'muStore', 'sigmaStore', 'zzStore', 'probStore')
