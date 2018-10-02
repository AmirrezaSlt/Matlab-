                % Advanced Reservoir Simulation by Dr. Pishvaie
                % Written by Vahid Azari 92207593
                % H.W. # 2 : Radial Bounded Oil Reservoir Simulation

                clear,clc;
                close all


                % Entering the reservoir properties:
                H=65;
                phi=0.2;
                miu=7;
                K=130;
                Bo=1.27;
                Ct=45e-6;
                rw=0.23;
                Pi=3100;
                Q=320;

                % Guess a reasonable value for the reservoir radius:
                re=1000;

                % Griding System
                % N=input('enter the number of the radial grid blocks :\n');
                N=20;

                % Uniform Grid Blocks:

                % r=zeros(1,N);
                % dr=zeros(1,N);
                % 
                % for ii=1:N
                %     dr(ii)=(re-rw)/N;
                % end
                % 
                % r(1)=rw+.5*dr(1);
                % for ii=2:N
                %     r(ii)=r(ii-1)+.5*(dr(ii-1)+dr(ii));
                % end


                % Adaptive Mesh:

                r=zeros(1,N+1);
                alg=(re/rw)^(1/N);
                r(1)=rw*log(alg)/(1-1/alg);
                for ii=2:N+1
                r(ii)=r(ii-1)*alg;
                end


                dr=zeros(1,N);
                dr(1)=(r(2)-r(1))/log(r(2)/r(1))-rw;
                for ii=2:N
                dr(ii)=(r(ii+1)-r(ii))/log(r(ii+1)/r(ii))-(r(ii)-r(ii-1))/log(r(ii)/r(ii-1));
                end
                % dr(N)=re-(r(N)-r(N-1))/log(r(N)/r(N-1));
                r=r(1:N);

                % Discretization
                h=zeros(1,N+1);
                h(1)=dr(1)/2;
                h(N+1)=.5*dr(N);
                for ii=2:N
                h(ii)=(dr(ii)+dr(ii-1))/2;
                end

                P=ones(1,N).*Pi;
                P_anal=ones(1,N).*Pi;
                Pbar=P;
                for ii=1:N
                P(ii)=Pi;
                end


                % Writing the equations
                dpdrw=Q*miu/(.00708*rw*K*H);


                dt=input('enter the time step in hrs:\n');
                n=input('how many time steps do you want to proceed?\n');

                m=input('which method do you want to apply?\n1.Robert–Asselin time filter\n2.Heun\n3.Adams–Bashford\n4.Runge–Kutta (fourth order)\n\n');

                tt=zeros(1,2);
                for nn=1:n

                % Time Filter
                if m==1

                if nn<=2
                k1=dt.*ffun(P(nn,:),h,r,phi,miu,Ct,K,dpdrw,N);
                k2=dt.*ffun(P(nn,:)+.5.*k1,h,r,phi,miu,Ct,K,dpdrw,N);
                k3=dt.*ffun(P(nn,:)+.5.*k2,h,r,phi,miu,Ct,K,dpdrw,N);
                k4=dt.*ffun(P(nn,:)+k3,h,r,phi,miu,Ct,K,dpdrw,N);
                P(nn+1,:)=P(nn,:)+(k1+2.*k2+2.*k3+k4)./6;
                else
                alfa=.8;
                Pbar(nn-1,:)=P(nn-1,:)+alfa.*(Pbar(nn-2,:)-2.*P(nn-1,:)+P(nn,:));
                P(nn+1,:)=Pbar(nn-1,:)+(2*dt).*ffun(P(nn,:),h,r,phi,miu,Ct,K,dpdrw,N);
                end
                %         plot(r,P)
                end

                %  Heun method
                if m==2
                k1=dt.*ffun(P(nn,:),h,r,phi,miu,Ct,K,dpdrw,N);
                k2=dt.*ffun(P(nn,:)+k1,h,r,phi,miu,Ct,K,dpdrw,N);
                P(nn+1,:)=P(nn,:)+.5.*(k1+k2);
                %         plot(r,P)
                end

                %  RK4 method
                if m==4
                k1=dt.*ffun(P(nn,:),h,r,phi,miu,Ct,K,dpdrw,N);
                k2=dt.*ffun(P(nn,:)+.5.*k1,h,r,phi,miu,Ct,K,dpdrw,N);
                k3=dt.*ffun(P(nn,:)+.5.*k2,h,r,phi,miu,Ct,K,dpdrw,N);
                k4=dt.*ffun(P(nn,:)+k3,h,r,phi,miu,Ct,K,dpdrw,N);
                P(nn+1,:)=P(nn,:)+(k1+2.*k2+2.*k3+k4)./6;
                %         plot(1:N,P)
                end

                %  Adams-Bash
                if m==3

                if nn<=3
                k1=dt.*ffun(P(nn,:),h,r,phi,miu,Ct,K,dpdrw,N);
                k2=dt.*ffun(P(nn,:)+.5.*k1,h,r,phi,miu,Ct,K,dpdrw,N);
                k3=dt.*ffun(P(nn,:)+.5.*k2,h,r,phi,miu,Ct,K,dpdrw,N);
                k4=dt.*ffun(P(nn,:)+k3,h,r,phi,miu,Ct,K,dpdrw,N);
                P(nn+1,:)=P(nn,:)+(k1+2.*k2+2.*k3+k4)./6;
                else
                Pstar=P(nn,:)+(dt/24).*(55.*ffun(P(nn,:),h,r,phi,miu,Ct,K,dpdrw,N)-59.*ffun(P(nn-1,:),h,r,phi,miu,Ct,K,dpdrw,N)...
                +37.*ffun(P(nn-2,:),h,r,phi,miu,Ct,K,dpdrw,N)-9.*P(nn-3,:));
                P(nn+1,:)=P(nn,:)+(dt/24).*(9.*ffun(Pstar,h,r,phi,miu,Ct,K,dpdrw,N)+19.*ffun(P(nn,:),h,r,phi,miu,Ct,K,dpdrw,N)...
                -5.*ffun(P(nn-1,:),h,r,phi,miu,Ct,K,dpdrw,N)+ffun(P(nn-2,:),h,r,phi,miu,Ct,K,dpdrw,N));
                end
                %         plot(r,P)
                end

                % Now it is time to recalculate the pressure decline profile analytically
                % For tDA<0.08 we use Ei function and for tDA>=.08 we use pseudo steady
                % state flow equation

                t=nn*dt;
                if t<.08*phi*miu*Ct*pi*re^2/.000264/K
                P_anal(nn+1,:)=Pi-(70.6*Q*miu*Bo)./(K*H).*expint(948.*phi.*miu.*Ct.*r.^2./K./t);
                else
                pwf=Pi-(Q*miu*Bo)/(.00708*K*H)*((.0005274*K*t)/(phi*miu*Ct*re^2)+log(re/rw)-.75);
                P_anal(nn+1,:)=pwf+(141.2*Q*miu*Bo)./(K*H).*(log(r./rw)-.5.*(r./re).^2);
                end
                % if P(nn+1,1)<1000
                %     fprintf('Pwf was reached 1000psi at %fth iteration and terminated after %f hours.\n',nn,nn*dt)
                %    break 
                % end
                tt(nn+1)=nn*dt;
                end
                x=1:N;
                plot(x,P_anal)
                plot(r,P(1,:),'r-',r,P(11,:),'g-',r,P(101,:),'b-',r,P(1001,:),'k-')
                plot(x,P_anal(21,:),'r*')
                hold on
                plot(x,P(21,:),'rs')
                plot(x,P_anal(41,:),'b*')
                plot(x,P(41,:),'bs')
                % plot(x,P_anal(61,:),'k*')
                % plot(x,P(61,:),'ks')
                % xlabel('Node Point')
                % ylabel('P (psia)')
                % legend('t=100 hrs analytical','t=100 hrs RK4','t=200 hrs analytical','t=200 hrs RK4','t=300 hrs analytical','t=300 hrs RK4')
                % plot(tt,abs(P-P_anal)./P_anal*100)
                % xlabel('time (hrs)')
                % ylabel('relative error (%)')