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
    rep=10;
    noise=0:0.02:0.2;
    N=20;
    outN=5;
    match=zeros(11,rep);
    for n=1:length(noise)
        sigma=noise(n);
        for i=1:rep
            data=SData_GM(N,outN,sigma);
            data_name=['Sdata_' num2str(i),'vs',num2str(j),'.mat'];
            save(data_name,'K','ng','nh','numGT');
            result=run_Coopt_GMAD(data,'adj');
            matchn=sum(sum(result.X(:,1:data.ng)))
            fprintf('Nmatch:%d    GT:%d',matchn,N);
            match(n,i)=matchn;
        end
    end
    for i=1:11
        accuracy(i) =sum(match(i,:)/20)/rep;
    end
    fprintf('-----------------------')
    fprintf('accuracy:%f',accuracy);
end

