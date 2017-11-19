clear all
%Starting variables
numlanes=2;
density=.18;
gridpts=250;
numcars=round(density*numlanes*gridpts);
%numcars=ceil(density*gridpts*numlanes);
grid=zeros(numlanes,gridpts);
vmax=5;
badDriverp=0;
passfactor=1;

%Characteristics of Each car
%Column 1=starting position
%Column 2=ending position
%Column 3=current velocity
%Column 4=Current Lane
%Column 5=End Lane
%Column 6=Car type
%Column 7=Direction of lane change
%Column 8=Passing Probability
%Column 9=Personalized Max Speed

carChar=zeros(numcars,9);
carChar(1:ceil(numcars/2),1)=randsample(gridpts+1,ceil(numcars/2));
carChar(ceil(numcars/2)+1:numcars,1)=randsample(gridpts+1,numcars-ceil(numcars/2));
%carChar(:,1)=randsample(gridpts,numcars);    %randsample because not allowed to start in same place
carChar(:,3)=round(vmax*rand(1,numcars)); %Allowed to have same velocity though
carChar(1:ceil(numcars/2),4)=1;
carChar(ceil(numcars/2)+1:numcars,4)=2;

vehdist=zeros(1,100);
vehdist(1:95)=1;
vehdist(96:100)=2;
carChar(:,6)=randsample(vehdist,numcars,true);  %replacement is being allowed

carChar(:,8)=rand(1,numcars);

counter=0;

%setting up grid
for ii=1:numcars
   grid(carChar(ii,4),carChar(ii,1))=carChar(ii,6);
    
end

carChar(:,9)=round(10*betarnd(5,5,[1,numcars]));
figure(1)
hold on
title('Asymm Beta(5,5) critical Density')
figure(2)
hold on
title('Asymm Beta(5,5) critical Density')

%%
%Set new characteristics

while min(carChar(:,1))<gridpts && counter<gridpts*2
    carChar(:,7)=0;
   
    %accident
%     if counter>30 && counter <60
%        grid(:,gridpts/2)=4; 
%     end
        
    for ii=1:numcars
        clear gap*
        if carChar(ii,1)>=gridpts
            carChar(ii,:)=inf;
          end
          if carChar(ii,1)~=inf
              %vmax=carChar(ii,9);
        %People in the right lane
        if carChar(ii,4)==1
            gapsf=carChar(ii,1)-find(grid(1,:)~=0);
            gapsf(gapsf>=0)=-inf;
            gapf=-1*(max(gapsf))-1;    %number of empty sites ahead
            gapveh=find(carChar(:,1)==carChar(ii,1)+gapf+1);
            if carChar(gapveh(:),6)==2
                gapf=gapf-1;
            end
                
            if carChar(ii,3)>gapf && grid(2,carChar(ii,1))==0 && sum(grid(2,max([carChar(ii,1)-vmax,1]):carChar(ii,1)))==0 &&passfactor>carChar(ii,8)   %If could hit someone in front and there's no one besid and no one would hit you if switched lanes,
                carChar(ii,7)=1; %Car should move into left lane
                if sum(grid(2,carChar(ii,1):min([carChar(ii,1)+vmax,gridpts])))~=0
                    gapsfo=carChar(ii,1)-find(grid(2,:)~=0);
                    gapsfo(gapsfo>=0)=-inf;
                    gapfo=-1*(max(gapsfo))-1;
                    gapveh=find(carChar(:,1)==carChar(ii,1)+gapfo+1);
                    if carChar(gapveh(:),6)==2
                        gapfo=max([gapfo-1,0]);
                    end
                    carChar(ii,3)=min([gapfo,vmax,carChar(ii,3)+1]);
                        
                else 
                    carChar(ii,3)=min([vmax,carChar(ii,3)+1]);
                end
                 
            else %If all weren't met
                    carChar(ii,3)=min([gapf,vmax,carChar(ii,3)+1]);
            end
            
        %People in the second (left) lane
        elseif carChar(ii,4)==2
            if sum(grid(1,min([gridpts,max([carChar(ii,1)-vmax,1])]):carChar(ii,1)))==0 && sum(grid(1,max([carChar(ii,1),1]):min([gridpts,carChar(ii,1)+min([vmax,carChar(ii,3)+1])])))==0 && passfactor>carChar(ii,8)
                carChar(ii,3)=min([vmax,carChar(ii,3)+1]);
                carChar(ii,7)=-1;                
            else
                gapsf=carChar(ii,1)-find(grid(2,:)~=0);
                gapsf(gapsf>=0)=-inf;
                gapf=-1*(max(gapsf))-1;
                gapveh=find(carChar(:,1)==carChar(ii,1)+gapf+1);
            if carChar(gapveh(:),6)==2
                gapf=max([gapf-1,0]);
            end
                carChar(ii,3)=min([gapf,vmax,carChar(ii,3)+1]);
            end
        end
            
          end
    end
    
            carChar(:,5)=carChar(:,4)+carChar(:,7);
            carChar(:,2)=carChar(:,1)+carChar(:,3);
            carChar(:,1)=carChar(:,2);
    grid=zeros(numlanes,gridpts);        
    for ii=1:numcars
        if carChar(ii,1)~=inf
            carChar(ii,3)=max([carChar(ii,3)-binornd(1,badDriverp),0]);
            grid(carChar(ii,5),max([1,carChar(ii,2)]))=carChar(ii,6);    %update grid
        end
    end
    carChar(:,4)=carChar(:,5);


    %plot(counter,carChar(:,4),'Marker','*');
    %hold on

    counter=counter+1;
    x(:,counter)=carChar(2,2);
    y(:,counter)=carChar(2,4);
   vehcs=find(carChar(:,1)~=inf);
    avgv(counter)=mean(carChar(vehcs(:),3));
    %dact(counter)=size(vehcs,2)/gridpts/numlanes;
    %Q(counter)=density*avgv(counter);
        %plot3(carChar(:,4),carChar(:,2),counter,'Marker','.')
         figure(1)
         plot(counter,carChar(:,2),'Marker','.')
         hold on
%         figure(2)
%         scatter3(counter,x(counter),y(counter),'Marker','.')
%         hold on
        
        
        
end
carChar
counter
hold off
hold off