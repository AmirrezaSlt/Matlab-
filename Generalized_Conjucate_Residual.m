
function x=Generalized_Conjucate_Residual(A,b,x0)
    r(:,1)=b-A*x0;
    p(:,1)=r(:,1);
    x(:,1)=x0;
     for j=1:20
           a(j)=dot(r(:,j),A*p(:,j))/dot((A*p(:,j)),A*p(:,j));
           x(:,j+1)=x(:,j)+a(j)*p(:,j);
           if mod(j,10)==1
              r(:,j+1)=b-A*x(:,j+1);
           else
           r(:,j+1)=r(:,j)-a(j)*A*p(:,j);
           end
           for i=1:j
               beta(i,j)=-(dot(A*r(:,j+1),A*p(:,i)))/dot(A*p(:,i),A*p(:,i));
               p(:,j+1)=r(:,j+1)+beta(i,j)*p(:,i);
           end
           beta=sum(sum(beta));
           if norm(r) < 0.001
            break;
           end
        
     end
    x=x(:,j+1);
end