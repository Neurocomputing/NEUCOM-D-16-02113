
function F=F_GMAF(x,Data) 
%   OBJECTIVE FUNCTION of GMAF:F(X)
%F=x' * K * x 
%-------------------------------------------------------------
%INXUT
%   X:               vector format of Partial Permutation matrix
%   Data:
%     %               Data.K -- dissimilarity matrix of graph G
%     %               Data.ng -- nodes num of graph G
%     %               Data.nh -- nodes num of graph H
%-------------------------------------------------------------
%written by RowenaWong at May.2016 (wangjingjing2014@ia.ac.cn)
%-------------------------------------------------------------
F= x' * Data.K * x;
end

