function F=F_QAP(X,Data) 
%   OBJECTIVE FUNCTION of QAP:F(X)
%   F= trace(X' * Ag * X * Ah');
%-------------------------------------------------------------
%INXUT
%   X: Partial Permutation matrix(M X N) M=N
%   Data:
%     %               Data.Ag
%     %               Data.Ah
%     %               Data.ng
%     %               Data.nh (ng=nh)
%-------------------------------------------------------------
%written by RowenaWong at May.2016 (wangjingjing2014@ia.ac.cn)
%-------------------------------------------------------------
    F= trace(X' * Data.Ag * X * Data.Ah');
end

