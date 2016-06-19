function F=F_GMAD(X,Data) 
%   OBJECTIVE FUNCTION of GMAD:F(X)
%   F=sum(sum((Ag - X *Ah * X').*(Ag - X * Ah * X')));
%-------------------------------------------------------------
%INPUT
%   X: Partial Permutation matrix
%   Data:
%     %               Data.Ag -- Adjacent matrix of graph G
%     %               Data.Ah -- Adjacent matrix of graph H
%     %               Data.ng -- nodes num of graph G
%     %               Data.nh -- nodes num of graph H
%-------------------------------------------------------------
%written by RowenaWong at May.2016 (wangjingjing2014@ia.ac.cn)
%-------------------------------------------------------------
F=sum(sum((Data.Ag - X * Data.Ah * X').*(Data.Ag - X * Data.Ah * X')));
end

