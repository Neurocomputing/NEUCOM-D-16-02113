function exp_QAP(varargin)
% RUN_EXPERIMENT_QAP(varagin)
%-----------------------------------------------------------
%This example demos how to run libcoopt for QAP (quadratic assignment
%problem) automatcially
%Examples:
%    exp_QAP('sym')
%    exp_QAP('asym')
%    exp_QAP(root_path,'sym')     % root_path is the directory of libcoopt
%    exp_QAP(root_path,'asym')     % root_path is the directory of libcoopt
%LIBCOOPT 2016 Contact: wangjingjing2014@ia.ac.cn
%------------------------------------------------------------
if nargin==2
    root_path=varargin{1};
    task_type=varargin{2};
    
else 
    if nargin==1
        task_type=varargin{1};
        mpath=which('Coopt.m');
        i=strfind(mpath,'\');
        root_path=mpath(1:i(end));;
    else
        disp('Error')
    end 
end
task_name = 'QAP';

if strcmp(task_type,'sym')
    fprintf('experiment on symmetric QAP files!\n');    
    data_path= 'Experiment\Dataset\QAPlib\sym\';
    opt=load('qap_sym_opt.mat');
    opt=opt.opt;
else
    if strcmp(task_type,'asym')
    fprintf('experiment on asymmetric QAP files!\n');             
    data_path= 'Experiment\Dataset\QAPlib\asym\';
    opt=load('qap_asym_opt.mat');
    opt=opt.opt;
    else
      disp('Error: no task_type(sym or asym)');
      return;
    end
end
file=dir([root_path data_path '*.dat']);
lengthFiles=length(file);

% if '.mat' data not prepared, prepare and save data
fprintf('Preparing Data of QAP...\n');
for i=1:lengthFiles
    [Ag,Ah,ng,nh]=Read_QAP(file(i).name);
    save([root_path data_path file(i).name(1:end-4),'_data.mat'],'Ag','Ah','ng','nh');
end
disp('Data Prepared');
% LibCoopt for QAP
eta=0.001; % the stopping paramet   in conditional gradient algorithm
dgamma=0.001; % the learning step

QAP_result=cell(lengthFiles,1);
disp('Results');
awar_mean=0; 
for i=1:lengthFiles
    result=run_Coopt_QAP([file(i).name(1:end-4),'_data'],eta,dgamma);
    result.filename=file(i).name;
    result.opt=opt{find(strcmp(opt,file(i).name)),2};
    result.awar=result.obj/result.opt-1;
    awar_mean=awar_mean + result.awar;
    QAP_result{i}=result; 
    % print result
    print_exp_result(result);
    
end
% save result
% save(['QAP_result_' task_type],'QAP_result','task_type','eta','dgamma');
awar_mean=awar_mean/lengthFiles*100;
fprintf('awar_mean:%4.2f%%\n',awar_mean);
end

function print_exp_result(res)
    fprintf(res.filename);
    fprintf(':\n');
    fprintf('OBJ:%12.2f',res.obj);   
    fprintf('    OPT:%12.2f\n',res.opt);
    fprintf('awar:%6.2f%%\n',res.awar*100);
    fprintf('----------------------------------------\n');
end
 