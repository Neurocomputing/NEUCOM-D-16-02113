function [Ag,Ah,ng,nh]=ReadQAPFile(filename)
% Read Ag and Ah from QAPlib file
 fid = fopen(filename,'rt');  %
 if(fid<=0)
     disp('error opening file£¡')
     return;
 end
 tline = fgetl(fid);
 n=str2num(tline);
 Ag=fscanf(fid,'%f',[n,n]);
 Ah=fscanf(fid,'%f',[n,n]);
 ng=n;
 nh=n;
 fclose(fid);
end
