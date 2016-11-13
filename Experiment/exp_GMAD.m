function exp_GMAD(varargin)
% RUN_EXPERIMENT_GMAD(varagin)
%-----------------------------------------------------------
%This example demos how to run libcoopt for GMAD (the adjacency matrix based subgraph matching) automatcially
%Examples:
%    exp_GMAD
%    exp_GMAD(root_path) root_path is the directory of libcoopt 
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
data_path= [root_path  'Experiment\'];
    rep=5;
    noise=0:0.02:0.2;
    N=20;% gt
    outN=5;% outlier
    match=zeros(11,rep);
    for n=1:length(noise) 
        fprintf('Noise=%f\n',noise(n));
        sigma=noise(n);
        for i=1:rep
            [~,Ag,Ah,ng,nh,numGT]=SData(N,outN,sigma);
            data_name=['Sdata_' num2str(i),'vs',num2str(j),'.mat'];
            save([data_path data_name],'Ag','Ah','ng','nh','numGT');
            result=run_Coopt_GMAD(data_name);
            matchn=sum(sum(result.X(:,1:numGT)));
            fprintf('Nmatch:%d -GT:%d\n',matchn,N);
            match(n,i)=matchn;
        end
    end
    fprintf('-----------------------\n')
    for i=1:11
        accuracy(i) =sum(match(i,:)/N)/rep;
        fprintf('noise:%f--accuracy:%f\n',noise(i),accuracy(i));
    end   
end

