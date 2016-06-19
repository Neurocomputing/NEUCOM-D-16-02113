function nebla_F=nF_QAP(X,Data)
% GRADIENT OBJECTIVE FUNCTION of QAP:F(X)
% nebla_F(X)=2*(Ag*X*Ah' + Ag'*X*Ah)
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
    nebla_F=2*((Data.Ag*X*Data.Ah' + Data.Ag'*X*Data.Ah)); 
end 
