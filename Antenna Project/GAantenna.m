clc
clear
close all
%% Setup the GA
ff='testfunction';    %objective function
lambda=0.25;
npar=input('Please enter the number of antennas '); %receives the number of
%antennas from user
%% Stopping criteria 
maxit=100;  %maximum number of iterations
mincost=-99999999;  %minimum required cost
%% GA Parameters 
popsize = 16;  %size if the population
mutrate = 0.15;  %mutation rate 
selection = 0.5;   %selection rate 
nbits = 8;      %number of bits (per parameter)
Nt = nbits*npar;    %total number of bits 
keep = floor(selection*popsize);    %remaining population
%% Create the initial population
iga=0;  %generation counter
pop=round(rand(popsize,Nt));    %Random population of 1s and 0s 
par=gadecode(pop,2*lambda,4*lambda,nbits);;   %converts binary to continuous values  
cost=feval(ff,par,lambda);    %Calculates population cost using ff
[cost,ind]=sort(cost);  %min cost in element 1  
par=par(ind,:);pop=pop(ind,:);     %Sorts population with lowest cost first
minc(1)=min(cost); %Minimum of population
meanc(1)=mean(cost);    %Mean of population 
%% Iterate through generations 
while iga<maxit 
    iga=iga+1;     %increment generation counter
%% Pair and mate 
M=ceil((popsize-keep)/2);   %Number of matings 
prob=flipud([1:keep]'/sum([1:keep])); %weights chromosomes based upon position on the list
odds=[0 cumsum(prob(1:keep))']; %Probability distribution function
pick1=rand(1,M);    %mate #1
pick2=rand(1,M);    %mate #2
ic=1;
while ic<=M 
    for (id=2:keep+1)
        if (pick1(ic)<=odds(id) & pick1(ic)>odds(id-1))
            ma(ic)=id-1;%incidies of the chromosome that will mates
        end %if
        if (pick2(ic)<=odds(id) & pick2(ic)>odds(id-1))
            pa(ic)=id-1;%incidies of the chromosome that will mate
        end %if
    end %for
    ic=ic+1;
end
%% Performs matching using single point crossover
ix=1:2:keep;    %index of mate#1
xp=ceil(rand(1,M)*(Nt-1));    %crossover point
pop(keep+ix,:)=[pop(ma,1:xp) pop(pa,xp+1:Nt)];    %first offspring 
pop(keep+ix+1,:)=[pop(pa,1:xp) pop(ma,xp+1:Nt)];    %second offspring
%% Mutate the population
nmut=ceil((popsize-1)*Nt*mutrate); % total number of mutations 
mrow=ceil(rand(1,nmut)*(popsize-1))+1; % row to mutate
mcol=ceil(rand(1,nmut)*Nt); % column to mutate 
for (ii=1:nmut)
    pop(mrow(ii),mcol(ii))=abs(pop(mrow(ii),mcol(ii))-1); % toggles bits ii
end         
%% The population is re-evaluated for cost
par(2 : popsize,:)=gadecode(pop(2:popsize,:),2*lambda,4*lambda,nbits);  % decode 
cost(2:popsize)=feval(ff,par(2:popsize,:),lambda);
%% Sort the costs and associated parameters
[cost,ind]=sort(cost);
par=par(ind,:); 
pop=pop(ind,:);
%% Do statistics for a single nonaveraging run 
minc(iga+1)=min(cost);    %minimum
meanc(iga+1)=mean(cost);   %mean 
%% Stopping criteria 
if (iga>maxit | cost(1)<mincost)
    break
end
[iga cost(1)]
end %iga
%% Displaying the output
day=clock;
disp(datestr(datenum(day(1),day(2),day(3),day(4),day(5),day(6)),0))
disp(['optimized function is ' ff])
format short g
disp(['popsize = ' num2str(popsize) ' mutrate = ' num2str(mutrate) ' # par = ' num2str(npar)])
disp(['#generations=' num2str(iga) ' best cost=' num2str(cost(1))])
disp(['best solution'])
disp([num2str(par(1,:))])
disp('binary genetic algorithm')
disp(['each parameter represented by ' num2str(nbits) ' bits'])
figure
iters=0:length(minc)-1;
plot(iters,minc,iters,meanc,'-.');
xlabel('generation');ylabel('cost');
legend('Minimum','Mean')
