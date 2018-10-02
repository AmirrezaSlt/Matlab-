function [delta_pre,de_dw]=backpropagateSigmoidLayer(delta_new,w,dfnet,a)
[r,c]=size(w);
new_w=w(1:r-1,:);
delta_pre=tr_w*(delta_new.*dfnet);
de_dw=(delta_new.*dfnet)*transpose(a);
end
