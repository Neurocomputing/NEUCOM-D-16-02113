function exp_QAP(varargin)
% evaluated libcoopt on QAP 
% input: rootpath (optional)
%  RowenaWong( wangjingjing2014@ia.ac.cn) June.2016

if nargin<1
    root_path='E:\LibCoopt\';
end 
if nargin==1
    root_path=varargin{1}
end 


result_path=[root_path 'result\'];
if ~exist(result_path)
    mkdir(result_path);
end 
%% experiment on symmetric QAP files
fprintf('experiment on symmetric QAP files!\n');
data_path= [root_path  'Experiment\Dataset\QAPlib\sym'];
cd(data_path);
file=dir('*.dat');
lengthFiles=length(file);
QAP_sym_result=[];
objlist=[];
% prepare data
for i=1:lengthFiles
    [Ag,Ah,ng,nh]=Read_QAP(file(i).name);
    %parameter
    eta=0.001; % the stopping paramet   in conditional gradient algorithm
    dgamma=0.001; % the learning step
    save([file(i).name(1:end-4),'_data.mat'],'Ag','Ah','ng','nh');
end 
% Coopt on QAP
for i=1:lengthFiles
    result=run_Coopt_QAP([file(i).name(1:end-4),'_data'],eta,dgamma);
    result.filename=file(i).name;
    QAP_sym_result=[QAP_sym_result,result];
    objlist=[objlist result.obj];
    % print
    fprintf(result.filename);
    fprintf(':%.2f\n',result.obj);
end 
load opt_sym.mat
awar=objlist-opt;
awar=sum(double(awar./opt))/size(file,1);
fprintf('QAP_sym_result:\n')
fprintf('           awar:%.2f%%\n',awar*100);
save([result_path,'QAP_sym_result.mat'],'QAP_sym_result','eta','dgamma','awar');


%% experiment on asymmetric QAP files
fprintf('--------------------------------------\n')
fprintf('experiment on asymmetric QAP files!\n');
data_path= [root_path  'Experiment\Dataset\QAPlib\asym'];
cd(data_path);
file=dir('*.dat');
lengthFiles=length(file);
QAP_asym_result=[];
objlist=[];
% prepare data
for i=1:lengthFiles
    [Ag,Ah,ng,nh]=Read_QAP(file(i).name);
    %parameter
    eta=0.001; % the stopping paramet   in conditional gradient algorithm
    dgamma=0.001; % the learning step
    save([file(i).name(1:end-4),'_data.mat'],'Ag','Ah','ng','nh');
end 
% Coopt on QAP
for i=1:lengthFiles
    result=run_Coopt_QAP([file(i).name(1:end-4),'_data'],eta,dgamma);
    result.filename=file(i).name;
    QAP_asym_result=[QAP_asym_result,result];
    objlist=[objlist result.obj];
    % print
    fprintf(result.filename);
    fprintf(':%.2f\n',result.obj);
end 
load opt_asym.mat
awar=objlist-opt;
awar=sum(double(awar./opt))/size(file,1);
fprintf('QAP_asym_result:\n')
fprintf('           awar:%.2f%%\n',awar*100);
save([result_path,'QAP_asym_result.mat'],'QAP_asym_result','eta','dgamma','awar');
