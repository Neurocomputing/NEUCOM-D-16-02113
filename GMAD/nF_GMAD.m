function nebla_F=nF_GMAD(X,Data) 
%GRADIENT of OBJECTIVE FUNCTION of GMAD :nF(X)
%   F=sum(sum((Ag - X *Ah * X').*(Ag - X * Ah * X')));
%   nF=nebla_F=2*(X*(Ah'*X'*X*Ah + Ah*X'*X*Ah')-(Ag*X*Ah' + Ag'*X*Ah));
%-------------------------------------------------------------
%INXUT
%   X: Xartial Xermutation matrix
%   Data:
%     %               Data.Ag -- Adjacent matrix of graph G
%     %               Data.Ah -- Adjacent matrix of graph H
%     %               Data.ng -- nodes num of graph G
%     %               Data.nh -- nodes num of graph H
%     %               Data.vecflag=0;
%-------------------------------------------------------------
%written by RowenaWong at May.2016 (wangjingjing2014@ia.ac.cn)
%-------------------------------------------------------------

nebla_F=2*(X*(Data.Ah'*X'*X*Data.Ah + Data.Ah*X'*X*Data.Ah')...
        -(Data.Ag*X*Data.Ah' + Data.Ag'*X*Data.Ah));   
end
