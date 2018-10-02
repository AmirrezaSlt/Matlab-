clc
clear
close all
ref=[1,2,3];
test=[1,1,2,2,2,3,3,3];
[matching_cost,best_path]=Dtw_Sakoe(ref,test);