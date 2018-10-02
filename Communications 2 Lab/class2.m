clc
clear
close all
%Part 1
%  syms p 
%  h=-p*log2(p)-(1-p)*log2(1-p);
%  ezplot(p,h,[0,1])
%Part 2
sentence=('and an index operation should do the trick Knowing that millions of people around the world would be watching in person and on television and expecting great things from him');
% q1=size(strfind(sentence,'n'),2);
% q2=size(sentence,2);
% prob=q1/q2;
ds=double(sentence);
ds1=size(sentence,2);
[n,x]=hist(ds,unique(ds));
n2=n/ds1;
%Part 3
h11=-n2.*log2(n2);
h1=sum(h11)
%part 4
[dict,avglength]=huffmandict(x,n2);
huffenco=huffmanenco(sentence,dict);
nbar=size(huffenco,2)./size(sentence,2)
%Part 5
p=ones(1,24)*(1/24);
[dict2,avglength2]=huffmandict(x,p);
huffenco2=huffmanenco(sentence,dict2);
h2=sum(-p.*log2(p))
nbar2=size(huffenco2,2)/size(ds,2)


