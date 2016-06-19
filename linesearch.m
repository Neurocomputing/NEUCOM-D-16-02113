function X=linesearch(Y,X,PairData,gamma,eta,F)
        %line search X=X+alfa*(Y-X)
        %divided method 1
        Xright = Y;
        Xleft = X;
        deltaY = (Xright - Xleft);
        for i = 1:10
            Xnew = Xleft + 0.5 * deltaY;
            Xnew2 = Xleft + (0.5 + eta) * deltaY;
%             F0 = fl(Ah,Ag, Xnew, gamma);
%             F1 = fl(Ah, Ag, Xnew2, gamma);
              % Fgamma0
              if gamma > 0
                Fgamma0 = gamma * sum(sum((Xnew.*Xnew))) + (1-gamma) *F(Xnew,PairData);
              else
                Fgamma0 = gamma * sum(sum((Xnew.*Xnew))) + (1+gamma) * F(Xnew,PairData);
              end
              %Fgamma1
              if gamma > 0
                Fgamma1 = gamma * sum(sum((Xnew2.*Xnew2))) + (1-gamma) *F(Xnew2,PairData);
              else
                Fgamma1 = gamma * sum(sum((Xnew2.*Xnew2))) + (1+gamma) *F(Xnew2,PairData);
              end
            if Fgamma0 < Fgamma1
               Xright = Xnew;
            else
               Xleft = Xnew;
            end
            deltaY = Xright - Xleft;
        end
        X = Xnew;
end 
