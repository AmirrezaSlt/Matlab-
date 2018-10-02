clc
clear
close all
% Part 1
ref='beauty';
test='beaty';
[edit_cost1,pred1]=edit_distance(ref,test)
% Part 2
test='biauty';
[edit_cost2,pred2]=edit_distance(ref,test)
% Part 3 
test='betty';
[edit_cost3,pred3]=edit_distance(ref,test)