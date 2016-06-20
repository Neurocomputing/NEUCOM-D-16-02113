 function s = ChrMatchShow (chr1,chr2,P0,Ps)
%-----------------------------------------------------------------%
% ChrMatchShow: show the correspondence result of two characters
%-----------------------------------------------------------------%
% chr1,chr2:data of characters 
%             % 1, 1st character: 1бл10; 2nd character: 11бл20; 3th character: 21бл30; 4th character: 31бл40.
%             % 
%             % 2, I is the image data.
%             % 
%             % 3, Pt is the marked points, with Pt(:,1) as the row no. and Pt(:,2) as the column no.
%             % 
%             % 4, N is the number of points in the current image.
%             % 
%             % 5гмG is the structure of the points.
% P0: ground truth matching 
% P:  matching result of two characters  
% ---------------------------------------------------------------------
 
Mg=chr1.I;Mh=chr2.I;
N=chr1.N;
pt_g=chr1.Pt(1:N,:);pt_h=chr2.Pt(1:N,:);    
G1=chr1.G;G2=chr2.G;
 clear chr1 chr2;
%
[M1,N1,K1]=size(Mg);
[M2,N2,K2]=size(Mh);
if K1 < K2
   Mg = repmat(Mg , [1 1 3]);
   K1 = K2;
elseif K1 > K2
   Mh = repmat(Mh , [1 1 3]);
   K2 = K1;
end
N3=N1+N2;
M3=max(M1,M2);
ig = 0 + floor((M3 - M1)/2);
jg = 0;
ih = 0 + floor((M3 - M2)/2);
jh = N1;

I=uint8(ones(M3,N3,K1) * 255);
I(ig+(1:M1),jg+(1:N1),:) = Mg ;
I(ih+(1:M2),jh+(1:N2),:) = Mh ;
% I = I / max(max(max(I)));
s = imshow(I);
hold on; 
% axis image ;
x = [ pt_g(: , 2) + jg;  pt_h(: , 2) + jh ] ;
y = [ pt_g(: , 1) + ig;  pt_h(: , 1) + ih ] ;
scatter(x, y, '.');

% structure
G1 = triu(G1);
for i = 1 : size(G1,1)
gs = pt_g(G1(i,:)>0, :);
x = [ pt_g(i,2)*ones(1,size(gs,1)) + jg ; gs(: , 2)' + jg ] ; x = [x; NaN * ones(1, size(x, 2))];
y = [ pt_g(i,1)*ones(1,size(gs,1)) + ig ; gs(: , 1)' + ig ] ; y = [y; NaN * ones(1, size(y, 2))];
h = line(x(:)', y(:)') ;
set(h,'MarkerSize',10,'Marker','.','Color','yellow', 'LineWidth',2) ;
end
G2 = triu(G2);
for i = 1 : size(G2,1)
hs = pt_h(G2(i,:)>0, :);
x = [ pt_h(i,2)*ones(1,size(hs,1)) + jh ; hs(: , 2)' + jh ] ; x = [x; NaN * ones(1, size(x, 2))];
y = [ pt_h(i,1)*ones(1,size(hs,1)) + ih ; hs(: , 1)' + ih ] ; y = [y; NaN * ones(1, size(y, 2))];
h = line(x(:)', y(:)') ;
set(h,'MarkerSize',10,'Marker','.','Color','yellow', 'LineWidth',2) ;
end

% Correspondence
Pr = P0 .* Ps; %green right
Pw = Ps - Pr; %red  wrong

% right correspondence
gr = pt_g .* [sum(Pr, 2) sum(Pr, 2)]; gr(find(1-sum(Pr, 2)), :) = [];
hr = Pr * pt_h; hr(find(1-sum(Pr, 2)), :) = [];
x = [ gr(: , 2)' + jg ; hr(: , 2)' + jh ] ; x = [x; NaN * ones(1, size(x, 2))];
y = [ gr(: , 1)' + ig ; hr(: , 1)' + ih ] ; y = [y; NaN * ones(1, size(y, 2))];
h = line(x(:)', y(:)') ;
set(h,'MarkerSize',10,'Marker','.','Color','g', 'LineWidth',1.5) ;

% wrong correspondence
gw = pt_g .* [sum(Pw, 2) sum(Pw, 2)]; gw(find(1-sum(Pw, 2)), :) = [];
hw = Pw * pt_h; hw(find(1-sum(Pw, 2)), :) = [];
x = [ gw(: , 2)' + jg ; hw(: , 2)' + jh ] ; x = [x; NaN * ones(1, size(x, 2))];
y = [ gw(: , 1)' + ig ; hw(: , 1)' + ih ] ; y = [y; NaN * ones(1, size(y, 2))];
h = line(x(:)', y(:)') ;
% set(h,'Marker','.','Color','r','LineWidth',1.5, 'LineStyle', ':');
set(h,'MarkerSize',10,'Marker','.','Color','r','LineWidth',1.5);
% 
% annotation(gcf,'textbox',...
%     [0.477888730385164 0.748397590361448 0.0613409415121255 0.0819277108433735],...
%     'String',{'GA'},...
%     'FontSize',14,...
%     'FitBoxToText','off',...
%     'LineStyle','none');



