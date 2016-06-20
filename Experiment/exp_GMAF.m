function exp_GMAF(varargin)
% evaluated libcoopt on GMAF 
% input: rootpath (optional)
%  RowenaWong( wangjingjing2014@ia.ac.cn) June.2016

if nargin<1
    root_path='E:\LibCoopt\';
end 
if nargin==1
    root_path=varargin{1}
end 
fprintf('experiment of GMAF on  chinese characters 1 vs 2!\n');
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
fprintf('Nmatch:%d\n',Nmatch);
fprintf('numGT:%d\n',numGT);
ChrMatchShow(chr1,chr2,P0,Ps);

end 

