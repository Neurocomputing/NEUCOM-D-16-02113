function exp_GMAD(varargin)
% evaluated libcoopt on GMAD
% input: rootpath (optional)
%  RowenaWong( wangjingjing2014@ia.ac.cn) June.2016

    if nargin<1
        root_path='E:\LibCoopt\';
    end
    if nargin==1
        root_path=varargin{1}
    end
    rep=5;
    noise=0:0.02:0.2;
    N=20;% gt
    outN=5;% outlier
    match=zeros(11,rep);
    for n=1:length(noise)
        fprintf('Noise=%f\n',noise(n));
        sigma=noise(n);
        for i=1:rep
            [~,Ag,Ah,ng,nh,numGT]=Sdata(N,outN,sigma);
            data_name=['Sdata_' num2str(i),'vs',num2str(j),'.mat'];
            save(data_name,'Ag','Ah','ng','nh','numGT');
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

