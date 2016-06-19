function result=run_Coopt_GMAF(varargin)
%Coopt for GMAF   
%-----------------------------------------------------------
% % F(X) and dF(X) is defined in F_GMAF and nF_GMAF
%-----------------------------------------------------------
% INPUT: 
%       data_path
%       vecflag default 1
%       eta       parameter of conditional gradient alg 
%                                   (default=0.001)
%       gamma     step of gamma decrease
%                                   (default=0.001)  
%Output£º
%       result(obj,time,X)
%----------------------------------------------------------
% demo:
% result=run_Coopt_GMAF('toy_GM')
% result=run_Coopt_GMAF('toy_GM',0.002,0.002)
%----------------------------------------------------------
% @RowenaWong(wangjingjing2014@ia.ac.cn)
%-----------------------------------------------------------
% parse parameter
[data_path,vecflag,para]=parse_arg2(varargin{:});
pairdata=load(data_path);
%M <=N
if pairdata.ng > pairdata.nh
            error('input error (M<=N)');
end
% X is vector
if ~vecflag
    error('X must be vector, vecflag=1')
end 

data.ng=pairdata.ng;data.nh=pairdata.nh;data.vecflag=vecflag;
%Coopt
        % copy need field of pairdata to data
        data.K=-pairdata.K; % max-->min  affinity matrix-->dissmilarity matrix
       % clear pairdata if needed
        clear pairdata;
        % Coopt        
        [obj,X,time]=Coopt(@F_GMAF,@nF_GMAF,data,para);
        % reshape X from vector to matrix (M X N)
        X=reshape(X,data.ng,data.nh);
% result
 result.obj=obj;
 result.X=X;
 result.time=time;
end 
function [data_path,vecflag,eta,dgamma] = parse_arg2(varargin)
%PARSE_ARG Parses the input arguments
    %
    switch nargin,
        case 4
            data_path    = varargin{1};
            vecflag      = varargin{2};
            eta          = varargin{3};
            dgamma       = varargin{4};
        case 3
            data_path = varargin{1};
            vecflag = 1;
            eta     = varargin{2};
            dgamma  = varargin{3};
        case 2
            data_path    = varargin{1};
            vecflag      = varargin{2};
            eta          =  0.001; % default
            dgamma       = 0.001;  % default
        case 1
            data_path  = varargin{1};
            vecflag   = 1;      %X is matrix(MXN, M<N)
            eta  =  0.001; %default
            dgamma = 0.001;  %default
        otherwise
            error('wrong argument.');
    end
end
 
 