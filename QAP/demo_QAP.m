% For QAP 
clear all;
toy_path='./Data/ToyData/';
load([toy_path,'toy_QAP']);
[obj, X]=run_GNCCP_QAP(Ag,Ah);
