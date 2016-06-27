function result=run_Coopt_GMAD(varargin)
%Coopt for GMAD   
%-----------------------------------------------------------
% % F(X) and dF(X) is defined in F_GMAD and nF_GMAD
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
% result=run_Coopt_GMAD('toy_GMAD')  
% result=run_Coopt_GMAD('toy_GMAD',0.002,0.002)
%----------------------------------------------------------
% @RowenaWong(wangjingjing2014@ia.ac.cn)
%-----------------------------------------------------------
% parse parameter
[data_path,vecflag,para]=parse_arg(varargin{:});
pairdata=load(data_path);
%M <=N
if pairdata.ng > pairdata.nh
            error('input error (Make sure M<=N)');
end

data.ng=pairdata.ng;data.nh=pairdata.nh;data.vecflag=vecflag;
%Coopt
if (~vecflag)
        % copy need field of pairdata to data
        data.Ag=pairdata.Ag;
        data.Ah=pairdata.Ah;
        % clear pairdata if needed
        clear pairdata;
        % Coopt
        [obj,X,time]=Coopt(@F_GMAD,@nF_GMAD,data,para);
else
    error('GMAD: X is matrix(M,N), M<=N, can not be set as vector')
end 
% result
 result.obj=obj;
 result.X=X;
 result.time=time;
end 

 
 