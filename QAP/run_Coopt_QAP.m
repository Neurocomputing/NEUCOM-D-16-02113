function solution=run_Coopt_QAP(varargin)
%Coopt for quadratic assignment problem
%-----------------------------------------------------------
% % F(X) and dF(X) is defined in F_QAP and nF_QAP
%-----------------------------------------------------------
% INPUT:
%       data_path
%       (vecflag default)
%       eta       parameter of conditional gradient alg
%                                   (default=0.001)
%       gamma     step of gamma decrease
%                                   (default=0.001)
%Output£º
%       solution(obj,time,X)
%----------------------------------------------------------
% demo
% solution=run_Coopt_QAP('toy_QAP')
% solution=run_Coopt_QAP('toy_QAP',0.002,0.002)
%----------------------------------------------------------
% @RowenaWong(wangjingjing2014@ia.ac.cn)
%-----------------------------------------------------------

% parse parameter
[data_path,vecflag,para]=parse_arg(varargin{:});
pairdata=load(data_path);
if pairdata.ng ~= pairdata.nh
    error('input error (Make sure M=N)');
end
data.ng=pairdata.ng;data.nh=pairdata.nh;data.vecflag=vecflag;
% Coopt
if (~vecflag)
    % copy need field of pairdata to data   e.g data.Ag=pairdata.Ag;
    data.Ag=pairdata.Ag;
    data.Ah=pairdata.Ah;
    % preprocessing if needed
    Ag_max=max(max(abs(data.Ag)));
    Ah_max=max(max(abs(data.Ah)));
    data.Ag=data.Ag/Ag_max;
    data.Ah=data.Ah/Ah_max;
    %       % clear pairdata if needed
    %       clear pairdata
    % Coopt
    [obj,X,time] = Coopt(@F_QAP,@nF_QAP,data,para);
else
    error('QAP: X is matrix(M,N), M<=N, can not be set as vector')
end
% obj for prior Ag and Ah ...
solution.obj=obj*Ag_max*Ah_max;
solution.X=X;
solution.time=time;
end
