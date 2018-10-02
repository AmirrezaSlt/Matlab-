function [matching_cost,best_path]=Dtw_Sakoe(ref,test)
I = length(ref);
J = length(test);
for i = 1:I
for j = 1:J
%Euclidean distance
node_cost(i,j) = sqrt(sum((ref(:,i)-test(:,j)).^2));
end
end
%Initialization
D(1,1) = node_cost(1,1);
pred(1,1) = 0;
for i = 2:I
D(i,1) = D(i-1,1)+node_cost(i,1);
pred(i,1) = i-1 + sqrt(-1)*1;
end
for j = 2:J
D(1,j) = D(1,j-1)+node_cost(1,j);
pred(1,j) = 1 + sqrt(-1)*(j-1);
end
%Main Loop
for i = 2:I
for j = 2:J
[D(i,j),ind] = min([D(i-1,j-1) D(i-1,j) ...
D(i,j-1)]+node_cost(i,j));
if (ind == 1)
pred(i,j) = (i-1)+sqrt(-1)*(j-1);
elseif (ind == 2)
pred(i,j) = (i-1)+sqrt(-1)*(j);
else
pred(i,j) = (i)+sqrt(-1)*(j-1);
end
end %for j
end %for i
%End of Main Loop
matching_cost = D(I,J);
best_path = back_tracking(pred,I,J);