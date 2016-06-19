function [obj, X,time] = Coopt(F,nF,Data,Para)
% % GNCCP
%%INPUT
%   F :objective function handle
%   nF:the derivative of F hanle
%   Data:    depended on cases
%      %     MUST: ng,nh: partial permutation matrix size
%      %               vecflag: in objection function, whether partial permuation matrix is vectorized
%      %                        ( 1 vectorized ,0 not vectorized)
%                  
% e.g.
%     %       GMAD:
%     %               Data.Ag -- Adjacent matrix of graph G
%     %               Data.Ah -- Adjacent matrix of graph H
%     %               Data.ng -- nodes num of graph G
%     %               Data.nh -- nodes num of graph H
%     %               Data.vecflag=0;
%     %       GMAF:
%     %               Data.K -- dissimilarity matrix of graph G
%     %               Data.ng -- nodes num of graph G
%     %               Data.nh -- nodes num of graph H
%     %               Data.vecflag=1;
%     %       QAP:
%     %               Data.Ag
%     %               Data.Ah
%     %               Data.ng
%     %               Data.nh
%     %               Data.vecflag=0;
%     %       TSP:
%     %               Data.D  distance matrix for N cities
%     %               Data.F  constant matrix (NxN) Fij=1 if i=n,j=1 orj=i+1
%     %                                                 Fij=0  otherwise
%     %               Data.ng -- N (number of cities)
%     %               Data.nh -- N (number of cities)
%     %               Data.vecflag=0;

%  Para
%              eta       Parameter of conditional gradient alg
%                                   (default=0.001)
%              gamma     step of gamma decrease
%                                   (default=0.01)
%--------------------------------------------------------------------------
%%OUTPUT
%   obj: objective value
%   X:   minimal point
%   time: running time
%--------------------------------------------------------------------------
%written by Prof. Zhi-Yong Liu, at Mar. 2014
%edited by RowenaWong at May.2016 (wangjingjing2014@ia.ac.cn)
%--------------------------------------------------------------------------
%please cite the following two papers if using the programme
%[1] Zhi-Yong Liu and Hong Qiao, "GNCCP - Graduated NonCovexity and Concavity
%Procedre", IEEE Trans. PAMI, DOI: 10.1109/TPAMI.2013.223, 2014
%[2] Zhi-Yong Liu, H. Qiao, X. Yang and Steven C.H. Hoi, "Graph Maching by
%Simplified Convex-Concave Relaxation Procedure", IJCV, DOI: 10.1007/s11263-014-0707-7, 2014
%--------------------------------------------------------------------------
% Default parameter
if (isfield(Para,'eta'))
    eta = Para.eta;
else
    eta =0.001;
end
if (isfield(Para,'dgamma'))
    dgamma= Para.dgamma;
else
    dgamma=0.01;
end
% size of X(partiral permutation matrix)
ng=Data.ng;
nh=Data.nh;
tic;% time
% initialize X and gamma
if Data.vecflag
    X0=ones(ng*nh,1)/nh; % X is a vector
else
    X0 = ones(ng,nh)/nh;
end
X = X0;
gamma = 1;

% step=0;
while gamma > -1
    ite=0;
    % conditional gradient descent (CGD) alg.
    while 1
        %------------------------------------
        %iterator of CGD , for efficiency
        ite=ite+1;
        if ite>10
            break;
        end
        %----------------------------------
        % compute gradient
        if gamma > 0
            g =2* gamma * X + (1-gamma)*nF(X,Data);
            %2*gamma*X+(1-gamma)*deltaF
        else
            g =2* gamma * X + (1+gamma)*nF(X,Data);
        end
        % gradient value
        if trace(g * g') < eta
            break;
        end
        %subproblem for every gamma
        %initialP
        if Data.vecflag
            % X is vector
            Y= reshape(KM(-reshape(g,ng,nh)),ng*nh,1);
            % X is matrix
        else
            if nh~=ng
                % M<N
                G = zeros(nh, nh);
                G(1:ng, :) = g;
                maxv = max(max(g));
                G(ng+1:nh, :) = maxv*ones(nh-ng,nh);
                Y = KM(-G);
                Y = Y(1:ng,:); %Y
            else
                %M=N
                Y=KM(-g);
            end
        end
        % CGD stop check
        tmp = sum(sum(g.*(X-Y)));
        if tmp < 0;
            break;
        end
        %line search for alfa, X=X+alfa*(Y-X)
        X=linesearch(Y,X,Data,gamma,eta,F);
        %Fgamma_new
        if gamma > 0
            Fgamma_new = gamma * sum(sum((X.*X))) + (1-gamma) *F(X,Data);
        else
            Fgamma_new = gamma * sum(sum((X.*X))) + (1+gamma) * F(X,Data);
        end
        % gradient_new
        if gamma > 0
            g =2* gamma * X + (1-gamma)*nF(X,Data);
            %2*gamma*X+(1-gamma)*deltaF
        else
            g =2* gamma * X + (1-gamma)*nF(X,Data);
        end
        
        %CGD stop check
        tmp = sum(sum(g.*(X - Y)));
        if tmp < eta  * abs(Fgamma_new - tmp);
            break;
        end
    end % end of CGD
    
    if nh - trace(X'*X) < 0.1^3
        break;
    end
    %     step=step+1;
    % %     if ~mod(step,10)
    %         fprintf('%6.2f ',gamma);
    %         if ~mod(step,10)
    %             fprintf('\n')
    %         end
    % %     end
    gamma = gamma - dgamma;
    
end %end of gamma

% X MUST IN PI
if Data.vecflag
    X = reshape(KM(reshape(X,ng,nh)),ng*nh,1);
else
    if nh~=ng
        PG = zeros(nh, nh);
        PG(1:ng, :) = X;
        minv = min(min(X));
        PG(ng+1:nh, :) = minv*ones(nh-ng,nh);
        X = KM(PG);
        X = X(1:ng,:);
    else
        X=KM(X);
    end
end
time=toc;
obj=F(X,Data);
end


