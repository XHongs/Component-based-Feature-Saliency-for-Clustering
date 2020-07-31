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
