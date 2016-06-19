function result=run_Coopt_other(varargin)
%------------------------------------------------------------------------
% Coopt for other combinatorial optimization on partial permuation matrix
%------------------------------------------------------------------------
% F(X) and dF(X) is defined in F_other and nF_other
%------------------------------------------------------------
% INPUT:
%       data_path
%       vecflag: 0->X is matrix 1->X is matix
%       eta       parameter of conditional gradient alg 
%                                   (default=0.001)
%       gamma     step of gamma decrease
%                                   (default=0.001)   
%
% OUTPUT: result(obj,time,X)
%------------------------------------------------------------
% demo:
% result=run_Coopt_other('toydata')
% result=run_Coopt_other('toydata',1)
% result=run_Coopt_other('toydata',0.002,0.002)
% result=run_Coopt_other('toydata',0.002,0.002,1)
%------------------------------------------------------------
% @RowenaWong
%------------------------------------------------------------
% parse parameter
[data_path,vecflag,para]=parse_arg_other(varargin{:});
pairdata=load(data_path);
% M<=N
if pairdata.ng > pairdata.nh
            error('input error');
end

data.ng=pairdata.ng;data.nh=pairdata.nh;data.vecflag=vecflag; 

% Coopt
if (~vecflag) % X is matrix(M,N)
      % copy need field of pairdata to data   e.g data.Ag=pairdata.Ag;
      % ....
      % preprocessing if needed
      % ....
      % clear pairdata if needed
      % ....
      % Coopt
        [obj,X,time]=Coopt(@F_other,@nF_other,data,para);                
else %X is vector(MXN,1)
        % copy need field of pairdata to data   e.g data.K=pairdata.K;
        %....
        % clear pairdata if needed 
        %....
        % Coopt
        [obj,X,time]=Coopt(@F_other,@nF_other,data,para);
        % reshape X from vector to matrix(M,N) M<=N
        X=reshape(X,data.ng,data.nh);
end
% result
result.obj=obj;
result.X=X;
result.time=time;
end 

function [data_path,vecflag,eta,dgamma] = parse_arg_other(varargin)
%PARSE_ARG Parses the input arguments
%
    switch nargin,
        case 4
            data_path= varargin{1};
            vecflag = varargin{2};
            eta     = varargin{3};
            dgamma  = varargin{4};   
        case 3
            data_path = varargin{1};
            vecflag = 0;
            eta     = varargin{2};
            dgamma  = varargin{3}; 
        case 2
            data_path   = varargin{1};
            vecflag    = varargin{2};
            eta   =  0.001; % default
            dgamma = 0.001;  % default
        case 1
            data_path  = varargin{1};
            vecflag   = 0;      %X is matrix(MXN, M<N)
            eta  =  0.001; %default    
            dgamma = 0.001;  %default
        otherwise
            error('wrong argument.');
    end
end 
 
 