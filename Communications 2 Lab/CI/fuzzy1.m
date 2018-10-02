clc
clear
close all
[X,Y] = meshgrid(-4:0.25:4);
Z = sin(X.*Y) + sin(0.5*Y) + cos(3*X);
surf(X, Y, Z);

nonlinMap = newfis('approximator');
nonlinMap = addvar(nonlinMap,'input','X',[-4 4]);
nonlinMap = addvar(nonlinMap,'input','Y',[-4 4]);
nonlinMap = addvar(nonlinMap,'output','Z',[-3 3]);
for i = -4:0.25:4
    nonlinmap = addmf(nonlinMap,'input',1,strcat('X ',num2str(i)), 'trimf',[i-0.25, i , i+0.25]);
    nonlinmap = addmf(nonlinMap,'input',2,strcat('Y ',num2str(i)), 'trimf',[i-0.25, i , i+0.25]);
end
plotmf(nonlinMap, 'input', 1);