function nebla_F=nF_GMAF(x,Data)
% GRADIENT of OBJECTIVE FUNCTION of GMAD :nF(X)
%nF=2*(K'+ K)*x;
%-------------------------------------------------------------
%INXUT
%   x:                 vector format of Partial Xermutation matrix
%   Data:
%     %               Data.K -- dissimilarity matrix of graph G
%     %               Data.ng -- nodes num of graph G
%     %               Data.nh -- nodes num of graph H
%-------------------------------------------------------------
%written by RowenaWong at May.2016 (wangjingjing2014@ia.ac.cn)
%-------------------------------------------------------------
    nebla_F=2*(Data.K' + Data.K) *x;
end 

