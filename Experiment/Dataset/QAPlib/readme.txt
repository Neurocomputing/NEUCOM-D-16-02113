QAPlib
%--------------------------------------------------------------------------
Choose 8 symmetric and 8 asymmetric data from QAPlib benchmark datasets.[1]
symmetric qap optimal values are saved in qap_sym_opt
asymmetric qap optimal values are saved in qap_asym_opt 
The complete QAPlib benchmark dataset can be found in [2]
%--------------------------------------------------------------------------
The users can get QAP data by :[Ag,Ah,ng,nh]=Read_QAP(DataPath)
    Ag: matrix (MxM)
    Ah  matrix (NxN)
    ng  M
    nh  N  (M=N)
The users can run experiments of QAP by: 
        exp_QAP('sym');
        exp_QAP('asym');
%--------------------------------------------------------------------------
reference:
[1] R.~E. Burkard, S.~E. Karisch, F.~Rendl, Qaplib--a quadratic assignment problem
  library, Journal of Global optimization 10~(4) (1997) 391--403.
[2] http://anjos.mgi.polymtl.ca/qaplib/