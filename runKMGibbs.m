% Copyright (c) 2019 CSIT, Queen's University Belfast, UK
% Contact: x.hong@qub.ac.uk
% If you use this code please cite:
% "Component-based Feature Saliency for Clustering",
% X Hong, H Li, P Miller, J Zhou, L Li, D Crookes, Y Lu, X Li, H Zhou, 
% IEEE Transactions on Knowledge and Data Engineering, 2019 
% 
% This software is licensed for research and non-commercial use only.
% 
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.

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
