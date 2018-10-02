clc;
clear;

anfisedit

%Any data set you load must be an array with the data arranged as column
%vectors, and the output data in the last column.
load fuzex1trnData.dat
load fuzex2trnData.dat
load fuzex1chkData.dat
load fuzex2chkData.dat

% See Matlab Help on 
% "anfis and the ANFIS Editor GUI" to gain experience using this box