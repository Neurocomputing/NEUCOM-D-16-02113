function result=run_Coopt_TSP(varargin)
%Coopt for TSP   
%-----------------------------------------------------------
% % F(X) and dF(X) is defined in F_TSP and nF_TSP
%-----------------------------------------------------------
% INPUT: 
%       data_path
%       (vecflag default 0)
%       eta       parameter of conditional gradient alg 
%                                   (default=0.001)
%       gamma     step of gamma decrease
%                                   (default=0.001)  
%Output£º
%       result(obj,time,X)
%----------------------------------------------------------
% demo:
% result=run_Coopt_TSP('toy_TSP')  
% result=run_Coopt_TSP('toy_TSP',0.002,0.002)
%----------------------------------------------------------
% @RowenaWong(wangjingjing2014@ia.ac.cn)
%-----------------------------------------------------------
% parse parameter 
[data_path,vecflag,para]=parse_arg(varargin{:});
pairdata=load(data_path);
%M =N
if pairdata.ng > pairdata.nh
            error('input error (Make sure M=N)');
end

% Generate E matrix of TSP, add ng\nh filed
    n=pairdata.n;
    pairdata.E=E_gen(n);
    pairdata.ng=n;
    pairdata.nh=n;
    %linear transformation of D 
    maxD=max(max(pairdata.D));
    pairdata.D=pairdata.D/maxD;
% run Coopt
    [result.obj, result.X,result.time] = Coopt(@F_TSP,@nF_TSP,pairdata,para);
    result.obj=result.obj*maxD;
% GENERATE path from result.X 
    path=1:1:n;
    for i=1:n
     path(i)=find(result.X(i,:));
    end 
    start=find(path==1);
    if start~=1
        pathvec = [path(start:n),path(1:start-1)]; % path
    else
        pathvec =path;
    end 
    result.path=pathvec;
end 

function A=E_gen(Blength) 
% generate constant matrix (NxN)
% Fij=1 if i=n,j=1 orj=i+1                                                
% Fij=0  otherwise
    Aass=eye(Blength-1,Blength-1);
    A=zeros(Blength,Blength);
    A(Blength,1)=1;
    for i=1:Blength-1 
        for j=2:Blength 
            A(i,j)=Aass(i,j-1);
        end
    end
end 


 