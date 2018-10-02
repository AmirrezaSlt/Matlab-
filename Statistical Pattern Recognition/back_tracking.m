function best_path=back_tracking(pred,k,l)
Node = k+sqrt(-1)*l;
best_path = [Node];
while (pred(real(Node),imag(Node)) == 0)
Node = pred(real(Node),imag(Node));
best_path = [Node;best_path];
end
%Plot the best path
[I,J] = size(pred);
clf;
hold
for j = 1:J
for i = 1:I
plot(j,i,'r.')
end
end
plot(imag(best_path),real(best_path),'bx','MarkerSize',14,'LineWidth',1.5)
axis off