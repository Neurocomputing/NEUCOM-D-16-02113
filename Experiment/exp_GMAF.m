function exp_GMAF(varargin)
% RUN_EXPERIMENT_GMAF(varagin)
%-----------------------------------------------------------
%This example demos how to run libcoopt for GMAF (the affinity matrix based subgraph matching) automatcially
%Examples:
%    exp_GMAF
%    exp_GMAF(root_path) root_path is the directory of libcoopt 
% eg.   'H:\Codes\newlibcoopt\'

%LIBCOOPT 2016 Contact: wangjingjing2014@ia.ac.cn
%------------------------------------------------------------
if nargin<1
    mpath=which('Coopt.m');
    i=strfind(mpath,'\');
    root_path=mpath(1:i(end));
else 
    if nargin==1
        root_path=varargin{1};
    else
        disp('Error')
        return
    end 
end 

disp('experiment of GMAF on  chinese characters 1 vs 2!');
data_path= [root_path  'Experiment\Dataset\data_chrct'];
chr1=load([data_path '\' num2str(1)]);
chr2=load([data_path '\' num2str(2)]);
% generate pairdata
[K,ng,nh,numGT]= generate_ChrPair (chr1,chr2,0);
% graph match by adj or aff
data_name='ChrPair.mat';
save(data_name,'K','ng','nh','numGT');
result=run_Coopt_GMAF(data_name);
P0=eye(chr1.N,chr1.N);
Ps=result.X;
% show the matching result
Nmatch=sum(sum(result.X(1:numGT,1:numGT).*eye(chr1.N,chr1.N)));
fprintf('Nmatch:%d\n',Nmatch); % matched point number
fprintf('numGT:%d\n',numGT); % ground truth
ChrMatchShow(chr1,chr2,P0,Ps);

end 

