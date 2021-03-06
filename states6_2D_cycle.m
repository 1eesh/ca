clear all;
%I have 6 states from that email. Lets see what I can do with them. Hmm...
total_states = 6 ;
ruleset=[];
time=21;
size=21;


 
 
 
%%
%
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
 
 
 
 
 
 
 
if 1% we dont need this for the statistics section
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
%RULE
%The ruleset here is the new state when a cell receives a signal
%First line is change in state when you do receive a signal
%Second line is a change in state when you do not receive a signal
rule_original = [ 3 , 0 ;...
         1 , 0 ;...
         2 , 0 ;...
         2 , 0 ;...
         4 , 0 ;...
         1 , 0 ] ;
 
rule = rule_original(:,1) ;
 
 
end
 

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
          1 , 1 , 1 , 0 , 1 , 0 ] ;
      
 
final = rule .* graph ;
  
 
 
%%
 
%A graph with a cycle so we can see a comparision
cycle_graph = [ 0 , 0 , 0 , 0 , 0 , 0 ;...
                0 , 0 , 0 , 0 , 0 , 0 ;...
                0 , 0 , 0 , 0 , 0 , 0 ;...
                0 , 1 , 0 , 0 , 0 , 1 ;...
                1 , 0 , 0 , 1 , 0 , 0 ;...
                0 , 0 , 1 , 0 , 1 , 0 ] ;

      
 
cycle_final = rule .* cycle_graph ;
  
%cycle_final
%%
 
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 

 
 
 
%TYPE AND SIZE DEFINITION
A = randi([1 total_states],size,size,1);
 
%%
%%%%%%%%%%
%INITIALIZING FOR LAUREN PAPER
 
 
%%
A = repmat(A,[1 1 time]);
%imagesc(A(:,:,4))
 
 
%B is A for cyclic
B = A;
    
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%UPDATION 
 
for(t= 1:time-1),
 
%
    for(x=2:size-1)
        for(y=2:size-1)
            
       
            a_signal=0;        
            c_signal=0;
 
            
        %%FOR ACYCLIC and ACYCLIC
            for(i=[-1,0,1])
                for(j=[-1,0,1])
                   
                    %CHECK FOR THE ACYCLIC GRAPH
                    if( graph(A(x,y,t),A(x+i,y+j,t)) ~= 0  ) ,
                        a_signal=1;
                        a_signal_x = x+i;
                        a_signal_y = y+j;
                    end
                    
                    
                    %CHECK FOR THE CYCLIC GRAPH
                    if( cycle_graph(B(x,y,t),B(x+i,y+j,t)) ~= 0  ) ,
                        c_signal=1;
                        c_signal_x = x+i;
                        c_signal_y = y+j;
 
                    end
                    
                end
                
            end
            
            %%SIGNAL DECISION FOR ACYCLIC
                    if( a_signal == 1 ) ,
                        A(x,y,t+1) = final(A(x,y,t) ,A(a_signal_x,a_signal_y,t));
                         
              
                    else
                        A(x,y,t+1) = A(x,y,t);
 
                    end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
          
           %%SIGNAL DECISION for CYCLIC
                    if( c_signal == 1 ) ,
                        B(x,y,t+1) = cycle_final(B(x,y,t) ,B(c_signal_x,c_signal_y,t));
                         
                    else
                        B(x,y,t+1) = B(x,y,t);
 
                    end
            
            
 
        
        end
    end
end
%%
 
 %%
if 1 % we dont need this section for now !
figure
 
for(rec=1:time)
drawnow
subplot(121);
%%%PLOT FOR ACYCLIC
h = imagesc(A(2:size-2,2:size-2,rec));
axis square;
caxis([1 6]);
colormap(jet(6));
q = colorbar;
q.Location = 'southoutside';
xlabel(q, 'State Marker');
 
ylabel('Cell Position');
xlabel('Time Step');
title(strcat('Acyclic | Rule: ',mat2str(rule_original(:,1))))
ax = gca;
ax.YTick = 1.5 : 1 : size -0.5;
ax.XTick = 1.5 : 1 : size -0.5;
ax.YGrid = 'on';
ax.XGrid = 'on';
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
%%%
 
 
subplot(122);
%%%PLOT FOR CYCLIC
h = imagesc(B(2:size-2,2:size-2,rec));
axis square;
caxis([1 6]);
colormap(jet(6));
q = colorbar;
q.Location = 'southoutside';
%set(q,'YTick',[1,2,3,4,5,6])
 
%lcolorbar(labels,'fontweight','bold');
 
 
xlabel(q, 'State Marker');
ylabel('Cell Position');
xlabel('Time Step');
title(strcat('Cyclic | Rule: ',mat2str(rule_original(:,1))));
ax = gca;
ax.YTick = 1.5 : 1 : size -0.5;
ax.XTick = 1.5 : 1 : size -0.5;
ax.YGrid = 'on';
ax.XGrid = 'on';
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
%%%
 
 
M(rec) = getframe(gcf);
%close all;
end
 
 
%%Save Figure
%savefig(strcat(mat2str(big),mat2str(rule_original(:,1))))
%saveas(gcf,strcat(mat2str(big),mat2str(rule_original(:,1)),'.png'))
%clearvars -except big;
%end
%%
movie2avi(M,strcat('ligands3_states6_cyclesize3',mat2str(rule_original(:,1)),'.avi'))
end
