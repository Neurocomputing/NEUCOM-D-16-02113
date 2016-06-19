function pairdata= generate_PairData (Chrdata1,Chrdata2,Noutlier)
% Generate Adjacent matrix for character
% combine distance and direction information (alfa1,alfa 2)
%------------------------ --------------------------------------------------
% INPUT
%       Chrdata1: character data
%       Chrdata2: character data
%                 must have the following field
%           
% 
% OUTPUT 
%       
%--------------------------------------------------------------------------
N = Chrdata1.N; % ground truth 
% choose outliers randomly
sel2 = N+randperm(size(Chrdata2.Pt,1)-N); sel2 = sel2(1:Noutlier); 
% Position P1,P2
P1 = Chrdata1.Pt(1:N, :);
P2 = Chrdata2.Pt([1:N sel2], :);
N1 = N; N2 = N1+Noutlier; NumGT=N;
% Graph
G1=Chrdata1.G;
G2=Chrdata2.G;
%G2=Chrdata2.G0([1:N sel2],[1:N sel2]);
GG = kron(G1, G2);
% Feature
% ----adjacent matrix by edge length-------------%
Ag = zeros(N1, N1); Ah = zeros(N2, N2);
for i = 1 : N1
    for j = 1 : N1
    Ag(i, j) = norm(P1(i, [1 2]) - P1(j, [1 2])); 
    end
end
Ag = Ag/max(max(Ag));
for i = 1 : N2
    for j = 1 : N2
    Ah(i, j) = norm(P2(i, [1 2]) - P2(j, [1 2])); 
    end
end
Ah = Ah/max(max(Ah));
%------- affinity matrix by edge length-------%
K1 = zeros(N1*N2,N1*N2);
for i = 1 : N1
    for j = 1 : N1
    K1(((i-1)*N2+1):i*N2,((j-1)*N2+1):j*N2) = exp(-(Ag(i,j)-Ah).^2/0.15);
    end
end
% --------adj matrix by edge angle-----------%
o1 = zeros(N1,N1); o2 = zeros(N2,N2);
o1x = zeros(N1,N1); o1y = zeros(N1,N1);
for i = 1 : N1
    for j = 1 : N1
    ins = P1(j,:)-P1(i,:); o1x(i,j) = ins(2); o1y(i,j) = ins(1);
    end
end
i = sqrt(-1);
o1 = o1x + o1y * i; 
o1 = angle(o1);
mino1=min(min(o1));
o1=o1+abs(mino1)*ones(N1,N1);
o1 = o1/max(max(o1));

o2x = zeros(N2,N2); o2y = zeros(N2,N2);
for i = 1 : N2
    for j = 1 : N2
    ins = P2(j,:)-P2(i,:); o2x(i,j) = ins(2); o2y(i,j) = ins(1);
    end
end
i = sqrt(-1);
o2 = o2x + o2y * i; 
o2 = angle(o2);
mino1=min(min(o2));
o2=o2+abs(mino1)*ones(N2,N2);
o2 = o2/max(max(o2));
% -------------affinity matrix by engle angle ----------%
K2 = zeros(N1*N2,N1*N2);
for i = 1 : N1
    for j = 1 : N1
    K2(((i-1)*N2+1):i*N2, ((j-1)*N2+1):j*N2) = exp(-(o1(i, j)-o2).^2/0.15);
    end
end

%ng<nh
% adjacent matrix
% Ag= 0.5*Ag+0.5*o1; 
% Ah= 0.5*Ah+0.5*o2;
% affiniity matrix
K1 = K1.*GG; K2 = K2.*GG;
K = K1 + K2;
pairdata.Ag=Ag;
pairdata.Ah=Ah
pairdata.K=K;
pairdata.NumGT=NumGT;
pairdata.ng=N1;
pairdata.nh=N2;
end 


