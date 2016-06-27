function [K,Ag,Ah,ng,nh,numGT]=Sdata(Ngt,Noutlier,sigma)
% Generate Synthetic data  GM (Graph Matching)
% Ag,Ah--adjmat A--affmat
%--------------------------------------------------------------------------
% Input
%       Ngt:            ground truth, number of matching node pairs
%       Noutlier:       number of outlier 
%       sigma:          noise level change 
% 
% Construct Ag first, then generate outliers and add those outliers to Ag
% to construct Ah, the first gt nodes in Ag and Ah are  satisfying one to one correspondence
%----------------------------------------------------------------------------
% demo: Sdata_gm(20,10,0.01,5,'H:\GNCCP\data\GM\S_data\')
%--------------------------------------------------------------------------

 idx=1;
 M =Ngt; N =M+Noutlier; 
%  for rep_count = 1 : Rep
        % generate G and Ah
        % position
        Pg = rand(M,2); % G's positon
        Ph0 = Pg+sigma*randn(M,2);
        Ph1 = 2.5*rand(Noutlier,2); 
        Ph = [Ph0;Ph1]; % Ah's positon
        Ag = zeros(M,M); Ah = zeros(N,N);
        % G's adjacent matrix     
        for i = 1 : M
            for j = 1 : M
                Ag(i,j) = norm(Pg(i,:) - Pg(j,:)); 
            end
        end
        % Ah's adjacent matrix
        for i = 1 : N
            for j = 1 : N
                Ah(i,j) = norm(Ph(i,:) - Ph(j,:));
            end
        end     
        A = zeros(M*N, M*N);
        for i = 1 : M
            for j = 1 : M
                A(((i-1)*N+1):i*N,((j-1)*N+1):j*N)=exp(-(Ag(i,j)-Ah).^2/0.15);
            end
        end
        
        A_ = kron(Ag>0, Ah>0);% kronecker product, Direct Graph strucure of G and Ah 
        A = A.*A_;% affinity matrix of G and Ah 
        % save aff and adj matrix      
%         save([D_path 's' num2str(sigma) '_Ngt' ...
%             num2str(Ngt) '_Nout' num2str(Noutlier) '__' num2str(idx) '.mat' ], ...
%             'A', 'Ag', 'Ah');
%         idx=idx+1;
%  end
K=A;
ng=M;
nh=N;
numGT=Ngt;
 
 
end