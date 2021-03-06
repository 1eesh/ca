%I have 6 states from that email. Lets see what I can do with them. Hmm...
total_states = 6 ;

%Random sizes and times for 1D initialization.
size = 21;
time = 21;

%TYPE AND SIZE DEFINITION
A = ones(time,size);
A(1,:) = randi([1 total_states],1,size);



%Now what I am going to do is, I am going to have a ruleset and then when I
%am going to compare the results for graphs that have cycles and graphs
%that do not have cycles! And then I will change the initializations and
%the rulesets to see where that takes us.

%THREE THINGS THAT CAN COMPLETELY DEFINE FATE FOR OUR DETERMINISTIC MODEL:
    %GRAPH
    %RULESET
    %INITIALIZATION
    

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%INITIALIZATION
%Different ways to initialize the cells








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%RULE
%The ruleset here is the new state when a cell receives a signal
%First line is change in state when you do receive a signal
%Second line is a change in state when you do not receive a signal
rule_original = [ 0 , 0 ;...
         0 , 0 ;...
         0 , 0 ;...
         5 , 0 ;...
         6 , 0 ;...
         4 , 0 ] ;

rule = rule_original(:,1) ;

rule = [ rule rule rule rule rule rule];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%GRAPH FOR ACYCLIC - LEBON ET AL
graph = zeros(total_states,total_states);

%The graph from the lauren paper is the following DAG
graph = [ 0 , 0 , 0 , 0 , 0 , 0 ;...
          0 , 0 , 0 , 0 , 0 , 0 ;...
          0 , 0 , 0 , 0 , 0 , 0 ;...
          1 , 1 , 0 , 0 , 0 , 0 ;...
          1 , 1 , 0 , 0 , 0 , 0 ;...
          1 , 1 , 0 , 0 , 1 , 0 ] ;
      

final = rule .* graph ;
          


        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%HOW CAN THERE BE A CYCLIC GRAPH , WHAT ARE THE RULES AND EQUATIONS THAT
%WOULD GIVE US A CYCLIC GRAPH. THINK ABOUT IT.





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%UPDATION 

for(t= 1:time-1),

%
    for(i=2:size-1)
       
        
        if(   graph(A(t,i),A(t,i-1)) ~= 0   |   graph(A(t,i),A(t,i+1)) ~= 0 ),
            A(t+1,i) = final(A(t,i) ,1);
        else
                    A(t+1,i) = A(t,i);

        end
        
        %If a cell can change state without a signal   
        

        
    end
end

%
h = imagesc(A);
axis square
caxis([0 6])
colormap(summer(6))
q = colorbar
ylabel(q, 'State Marker')

xlabel('Cell Position')
ylabel('Time Step')
title(strcat('Acyclic | Rule: ',mat2str(rule_original(:,1))))
ax = gca;
ax.XTick = 1.5 : 1 : size -0.5;
ax.YTick = 1.5 : 1 : time -0.5;
ax.XGrid = 'on';
ax.YGrid = 'on';
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);



%grid on
