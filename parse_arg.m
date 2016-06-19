function [data_path,vecflag,eta,dgamma] = parse_arg(varargin)
%PARSE_ARG Parses the input arguments
%PARSE_ARG Parses the input arguments
    %
    switch nargin,
        case 4
            data_path    = varargin{1};
            vecflag      = varargin{2};
            eta          = varargin{3};
            dgamma       = varargin{4};
        case 3
            data_path = varargin{1};
            vecflag = 0;
            eta     = varargin{2};
            dgamma  = varargin{3};
        case 2
            data_path    = varargin{1};
            vecflag      = varargin{2};
            eta          =  0.001; % default
            dgamma       = 0.001;  % default
        case 1
            data_path  = varargin{1};
            vecflag   = 0;      %X is matrix(MXN, M<N)
            eta  =  0.001; %default
            dgamma = 0.001;  %default
        otherwise
            error('wrong argument.');
    end
end