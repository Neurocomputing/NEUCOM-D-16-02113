function nebla_F=nF_TSP(X,PairData)
     %   F= trace(E*X*D'*X')=trace(X*D'*X'*E);
     %   nebla_F=E*X*D'+E'*X*D;
     %   E is constant matrix predefined
     nebla_F=PairData.E*X*PairData.D' + PairData.E'*X*PairData.D;
end 
