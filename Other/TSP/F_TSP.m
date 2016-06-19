
function F=F_TSP(X,PairData) 
%  objective funciton of GM :F(X)
%  g<=h
%   F= trace(E*X*D'*X');
%   E is constant matrix
    F= trace( PairData.E * X * PairData.D'*X');
end