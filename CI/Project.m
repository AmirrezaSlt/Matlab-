clc
clear
clear classes
close all
GameEnding=0;
seq=1;
winsym=0;
b=zeros(3); 
disp('Welcome to the Tic Tac Toe game')
initiation=questdlg('X or O','XO','X','O','O');
figure
title('Tic Tac Toe')
axis([0 9 0 9])
ph=gca;
ph.XTick=0:3:9;
ph.YTick=0:3:9;
ph.GridAlpha=1;
ph.YTickLabel=[];
ph.XTickLabel=[];
grid on 
axis square
hold on       
while GameEnding==0
    if initiation=='X'
        if mod(seq,2)==1
             sym='X';
             [b,n,sym]=Usermove(sym,b);
        else 
             sym='O';
             [b,n,sym]=AImove(b,sym,seq);
        end    
    else 
         if mod(seq,2)==0
             sym='O';
             [b,n,sym]=Usermove(sym,b);
            
         else
             sym='X';
             [b,n,sym]=AImove(b,sym);
         end    
    end      
    [GameEnding,winsym]=CheckEnding(b,winsym,GameEnding);
    seq=seq+1;
end
if GameEnding==1
    NewGame=questdlg('Game Over','Game Over','Start a new game','Exit','Start a new game');
        switch NewGame
        case 'Exit'
        clc
        clear
        close all
        case 'Start a new game'
        project.m
        return
        end
end
function [b,n,sym]=AImove(b,sym,seq)
pause(0.5)
tb=b;
u=find(tb'==0);
row1=b(1,:);
row2=b(2,:);
row3=b(3,:);
col1=b(:,1);    
col2=b(:,2);
col3=b(:,3);
diag1=[b(1,1) b(2,2) b(3,3)];
diag2=[b(1,3) b(2,2) b(3,1)];
oneleft=find(b'==0);





if sym=='X'
    p=1;
elseif sym=='O'
    p=-1;
end
if length(oneleft)==1
    n=oneleft;
elseif b==[1,0,0;0,0,0;0,0,0] 
    n=5;
elseif b==[0,0,1;0,0,0;0,0,0]
    n=5;
elseif b==[0,0,0;0,0,0;1,0,0]
    n=5;
elseif b==[0,0,0;0,0,0;0,0,1]
    n=5;
elseif sum(row1)==2*p
    k=find(row1==0);
    n=k;
elseif sum(row2)==2*p
    k=find(row2==0);
    n=k+3;
elseif sum(row3)==2*p
    k=find(row3==0);
    n=k+6;
elseif sum(col1)==2*p
    k=find(col1==0);
    n=3*k-2;
elseif sum(col2)==2*p
    k=find(col2==0);
    n=3*k-1;
elseif sum(col3)==2*p
    k=find(col3==0);
    n=3*k;
elseif sum(diag1)==2*p
    k=find(diag1==0);
    n=4*k-3;
elseif sum(diag2)==2*p
    k=find(diag2==0);
    n=2*k+1;
elseif sum(row1)==-2*p
    k=find(row1==0);
    n=k;
elseif sum(row2)==-2*p
    k=find(row2==0);
    n=k+3;
elseif sum(row3)==-2*p
    k=find(row3==0);
    n=k+6;
elseif sum(col1)==-2*p
    k=find(col1==0);
    n=3*k-2;
elseif sum(col2)==-2*p
    k=find(col2==0);
    n=3*k-1;
elseif sum(col3)==-2*p
    k=find(col3==0);
    n=3*k;
elseif sum(diag1)==-2*p
    k=find(diag1==0);
    n=4*k-3;
elseif sum(diag2)==-2*p
    k=find(diag2==0);
    n=2*k+1;
else         
    
    
    
    
    
    
    
for i=1:size(u)
     if sym=='X'
       tb(u(i))=1;
       num=-1;
     elseif sym=='O'
        tb(u(i))=-1;
        num=1;
     end   
        for j=1:size(u)-1
        tb1=tb;
           if sym=='X'
               tb1(u(j~=i))=-1;
            elseif sym=='O'
                tb1(u(j~=i))=1;
            end   
         Xscore=0;
         Yscore=0;
         if tb1(1,1)~=num && tb1(2,1)~=num && tb1(3,1)~=num
              Xscore=Xscore+0.1;
         end
         if tb1(1,1)~=num && tb1(1,2)~=num && tb1(1,3)~=num
              Xscore=Xscore+0.1;
         end
         if tb1(2,1)~=num && tb1(2,2)~=num && tb1(2,3)~=num
              Xscore=Xscore+0.1;
         end
         if tb1(3,1)~=num && tb1(3,2)~=num && tb1(3,3)~=num
              Xscore=Xscore+0.1;
         end
         if tb1(1,2)~=num && tb1(2,2)~=num && tb1(3,2)~=num
              Xscore=Xscore+0.1;
         end
         if tb1(1,3)~=num && tb1(2,3)~=num && tb1(3,3)~=num
              Xscore=Xscore+0.1;
         end
         if tb1(1,1)~=num && tb1(2,2)~=num && tb1(3,3)~=num
              Xscore=Xscore+0.1;
         end
         if tb1(1,3)~=num && tb1(2,2)~=num && tb1(3,1)~=num
              Xscore=Xscore+0.1;
         end     
         if tb1(1,1)~=-num && tb1(2,1)~=-num && tb1(3,1)~=-num
              Yscore=Yscore+0.1;
         end
         if tb1(1,1)~=-num && tb1(1,2)~=-num && tb1(1,3)~=-num
              Yscore=Yscore+0.1;
         end
         if tb1(2,1)~=-num && tb1(2,2)~=-num && tb1(2,3)~=-num
              Yscore=Yscore+0.1;
         end
         if tb1(3,1)~=-num && tb1(3,2)~=-num && tb1(3,3)~=-num
              Yscore=Yscore+0.1;
         end
         if tb1(1,2)~=-num && tb1(2,2)~=-num && tb1(3,2)~=-num
              Yscore=Yscore+0.1;
         end
         if tb1(1,3)~=-num && tb1(2,3)~=-num && tb1(3,3)~=-num
              Yscore=Yscore+0.1;
         end
         if tb1(1,1)~=-num && tb1(2,2)~=-num && tb1(3,3)~=-num
              Yscore=Yscore+0.1;
         end
         if tb1(1,3)~=-num && tb1(2,2)~=-num && tb1(3,1)~=-num
              Yscore=Yscore+0.1;
         end     
         score(i,j)=Xscore-Yscore;
         tb1=tb;
        end 
 tb=b;
end
minscore=min(score);
[~,h]=max(minscore);
n=u(h);
end
b=updateboard(n,b,sym);
end
function [b,n,sym]=Usermove(sym,b)
 n=userinput;
 c=b';
    while  c(n)~=0
     disp('invalid input,please try again')
     n=userinput;
    end
 b=updateboard(n,b,sym);
end
function b=updateboard(n,b,sym)
r=mod(n,3);
if r==0
    r=r+3;
end
q=ceil(n/3);

switch n 
        case 1 
        text(1,7.5,sym,'fontsize',45)
        hold on
    case 2
        text(3.9,7.5,sym,'fontsize',45)
        hold on
    case 3
        text(7,7.5,sym,'fontsize',45)
        hold on
    case 4
        text(1,4.5,sym,'fontsize',45)
        hold on
    case 5
        text(3.9,4.5,sym,'fontsize',45)
        hold on
    case 6
        text(7,4.5,sym,'fontsize',45)
        hold on
    case 7
        text(1,1.5,sym,'fontsize',45)
        hold on
    case 8
        text(3.9,1.5,sym,'fontsize',45)
        hold on
    case 9  
        text(7,1.5,sym,'fontsize',45)
        hold on
end
    if sym=='X'
        b(q,r)=1;
    elseif sym=='O'
        b(q,r)=-1;
    end
end
function [GameEnding,winsym]=CheckEnding(b,winsym,GameEnding)
 if b(1,1)==b(1,2) && b(1,1)==b(1,3) && b(1,1)~=0
     winsym=b(1,1);
     GameEnding=1;
 elseif b(2,1)==b(2,2) && b(2,1)==b(2,3) && b(2,1)~=0
     winsym=b(2,1);
     GameEnding=1;
 elseif b(3,1)==b(3,2) && b(3,1)==b(3,3) && b(3,1)~=0
      winsym=b(3,1);
      GameEnding=1;
 elseif b(1,1)==b(2,1) && b(1,1)==b(3,1) && b(1,1)~=0
      winsym=b(1,1);  
      GameEnding=1;
 elseif b(1,2)==b(2,2) && b(1,2)==b(3,2) && b(1,2)~=0
      winsym=b(1,2); 
      GameEnding=1;
 elseif b(1,3)==b(2,3) && b(1,3)==b(3,3) && b(1,3)~=0
      winsym=b(1,3);
      GameEnding=1;
 elseif b(1,1)==b(2,2) && b(1,1)==b(3,3) && b(1,1)~=0
      winsym=b(1,1);
      GameEnding=1;
 elseif b(1,3)==b(2,2) && b(1,3)==b(3,1) && b(1,3)~=0
      winsym=b(1,3);     
      GameEnding=1;
 elseif   b(1,1)*b(1,2)*b(1,3)*b(2,1)*b(2,2)*b(2,3)*b(3,1)*b(3,2)*b(3,3)~=0  
      GameEnding=1;
      disp('Draw')
 end
 switch winsym
     case -1
         disp('O wins')
     case 1
         disp('X wins')
 end       
end
function n=userinput
    [x,y]=ginput(1);
    if x>0 && x<3 && y>0 && y<3
        n=7;
    elseif x>0 && x<3 && y<6 && y>3   
        n=4;
    elseif x>0 && x<3 && y>6 && y<9   
        n=1;
    elseif x>3 && x<6 && y>6 && y<9   
        n=2;
    elseif x>6 && x<9 && y>6 && y<9   
        n=3;
    elseif x>6 && x<9 && y>3 && y<6   
        n=6;
    elseif x>6 && x<9 && y>0 && y<3   
        n=9;
    elseif x>3 && x<6 && y>0 && y<3   
        n=8;    
    elseif x>3 && x<6 && y>3 && y<6   
        n=5;
    else
        disp('invalid input,please try again')
    end
end
