clear all

for density=0.01:0.01:1
    clearvars -except density
%Starting variables
numlanes=2;
%numcars=249;
gridpts=250;
numcars=round(density*gridpts*numlanes);
grid=zeros(numlanes,gridpts);
vmax=10;
badDriverp=0;
passfactor=1;

%Characteristics of Each car
%Column 1=starting position
%Column 2=ending position
%Column 3=current velocity
%Column 4=Current Lane
%Column 5=End Lane
%Column 6=Car type
%Column 7=Rank of vehicle
%Column 8=Rudeness Factor
%Column 9=Personalized Max Speed

carChar=zeros(numcars,9);
carChar(:,3)=round(vmax*rand(1,numcars)); %Allowed to have same velocity though

vehdist=zeros(1,100);
vehdist(1:95)=1;
vehdist(96:100)=2;
carChar(:,6)=randsample(vehdist,numcars,true);  %replacement is being allowed

carChar(:,8)=rand(1,numcars);

%setting up grid
for ii=1:numcars
    carChar(ii,4)=mod(ii,numlanes)+1;
    carChar(ii,1)=mod(ii,gridpts)+1;
   grid(carChar(ii,4),carChar(ii,1))=carChar(ii,6);
    
end

carChar(:,9)=round(10*betarnd(5,5,[1,numcars]));
%%
%Set new characteristics
counter=0;
while min(carChar(:,1))<gridpts && counter<gridpts*2
    [a,carChar(:,7)]=sort(carChar(:,1),'descend');
    %accident
%     if counter>30 && counter <60
%        grid(:,gridpts/2)=1000; 
%     end
        
    for ii=1:numcars
        [a,loc]=min(carChar(:,7));
        clear gap*
        if carChar(loc,1)>=gridpts
            carChar(loc,:)=inf;
        end
          if carChar(loc,1)~=inf
              vmax=carChar(loc,9);
              %%Lane Changes
              %Moving to rightmost available lane
              if carChar(loc,4)~=1 && sum(sum(grid(:,max([1,carChar(loc,1)]):min([carChar(loc,1)+vmax,gridpts])))) && passfactor>=carChar(loc,8)  %if not in rightmost land and no one within hitting distance in front of you
                  if sum(grid(1:max([1,carChar(loc,4)-1]),carChar(loc,1)))==0  %If no one in any of the lanes to the right of them in their same position
                      carChar(loc,5)=1;
                  else
                      gapsr=carChar(loc,4)-find(grid(:,4)~=0);
                      gapsr(gapsr>=0)=-inf;
                      gapr=-1*max(gapsr)-1;
                      carChar(loc,5)=max([1,carChar(loc,4)-gapr]);
                  end
              %Or moving left one lane
              elseif carChar(loc,4)~=numlanes && sum(sum(grid(:,carChar(loc,1):min([gridpts,carChar(loc,1)+vmax]))))~=0 && sum(grid(carChar(loc,4)+1,max([1,carChar(loc,1)-vmax]):carChar(loc,1)))==0 &&passfactor>carChar(loc,8)
                 carChar(loc,5)=carChar(loc,4)+1; 
              else
                  carChar(loc,5)=carChar(loc,4);
              end
          %Forward Movement
              gapsf=carChar(loc,1)-find(carChar(:,5)==carChar(loc,4));
              gapsf(gapsf>=0)=-inf;
              gapf=-1*(max(gapsf))-1;    %number of empty sites ahead
              if size(gapf,1)~=0
                  gapveh=find(carChar(:,1)==carChar(loc,1)+gapf+1);
                  if carChar(gapveh(:),6)==2
                      gapf=max([gapf-1,0]);
                  end
              else 
                  gapf=inf;
              end
              
              carChar(loc,3)=max([0,min([gapf,vmax,carChar(loc,3)+1])]);
              carChar(loc,3)=max([carChar(loc,3)-binornd(1,badDriverp*carChar(loc,8)),1]);
              carChar(loc,2)=carChar(loc,3)+carChar(loc,1);            
              
          %Update Grid
          grid(carChar(loc,4),carChar(loc,1))=0;   %Their old grid point is now empty
          grid(carChar(loc,5),carChar(loc,2))=carChar(loc,6);    %Their new grid point is now its car type
          end
          carChar(loc,7)=inf;
    end
    carChar(:,1)=carChar(:,2);
    carChar(:,4)=carChar(:,5);
    counter=counter+1;

    %plot(counter,carChar(:,2),'Marker','*')
    %plot(counter,carChar(:,4),'Marker','*');
    %hold on
   vehcs=find(carChar(:,1)~=inf);
    avgv(counter)=mean(carChar(vehcs(:),3));
    %dact(counter)=size(vehcs,2)/gridpts/numlanes;
    Q(counter)=density*avgv(counter);
end
    figure(1)
 plot(density,mean(Q),'Marker','*')
 hold on
 figure(2)
 plot(density,mean(avgv),'Marker','*')
 hold on
end
%%

 
figure(1)
xlabel('Initial Density')
ylabel('Average Flow')
title('Fundamental Diagram with Even Spread Medium Speed Beta Distribution')
hold off

figure(2)
xlabel('Initial Density')
ylabel('Average Velocity')
title('Average Velocity with Even Spread Medium Beta Distribution vs. Initial Density')
hold off

carChar
counter