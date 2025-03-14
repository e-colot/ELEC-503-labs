function [u,y] = ReadData(FileName,N,Nrep)

% Starting from a measurement with multiple repetitions, 
% this function combines all the measured input signals into a matrix u, 
% and all the measured output signals into another matrix y. 

% Example: [u,y] = Read('Output_Q1.mat',40)

% Input:
    % Filename: Name of the matfile containing the measurements
    % N: Number of samples in 1 repetition
    % Nrep: Number of repetitions
    
% Output:
    % u: NxNrep input matrix 
    % y: NxNrep output matrix 
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data = load(FileName);

u = zeros(N,Nrep);
y = zeros(N,Nrep);

for ii = 0:Nrep-1
    if ii == 0 
        data_u = 'Su';
        data_y = 'Sy';
    else 
        data_u = sprintf('Su%d',ii);
        data_y = sprintf('Sy%d',ii);
    end
    u(:,ii+1) = data.(data_u);    
    y(:,ii+1) = data.(data_y); 
end

end