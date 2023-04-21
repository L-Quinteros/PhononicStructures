function Plot_Structure(ne,connect,coord,xbeam_area,xbeam_mat)
    coord=coord*100;
    fig=figure('units','inch','position',[0,0,3.6,2.9]);
    for ele=1:ne
        % recover the nodes
        node = connect(ele,:);
        %println(node1," ",node2)

        % recover the coordinates
        %[x1,y1,z1] = coord(node(1),:);
        %[x2,y2,z2] = coord(node(2),:);
        vect1 = coord(node(1),:);
        vect2 = coord(node(2),:);        

        % Adds a line to the plot
        if xbeam_mat(ele)==0.0
            %n=1;
            L(1)=plot([vect1(1);vect2(1)],[vect1(2);vect2(2)],'b','LineWidth',1+3*xbeam_area(ele));
            %if n=1;
            %    legend()
            %end
            
            hold on
        elseif xbeam_mat(ele)==1.0
            L(2)=plot([vect1(1);vect2(1)],[vect1(2);vect2(2)],'r','LineWidth',1+3*xbeam_area(ele));
            hold on 
        end
       L(3) = plot(nan, nan,'b');
       L(4) = plot(nan, nan,'r');
       L(5) = plot(nan, nan,'b','LineWidth',4);
       L(6) = plot(nan, nan,'r','LineWidth',4);
       %if material ==1
        %legend(L([3:6]), {'Aluminio - Espesor 1','Tungsteno - Espesor 1','Aluminio - Espesor 2','Tungsteno - Espesor 2'})
       %elseif material ==2
        %   legend(L([3:6]), {'Aluminio - Espesor 1','Titanio - Espesor 1','Aluminio - Espesor 2','Titanio - Espesor 2'})
       %elseif material ==3
         %  legend(L([3:6]), {'Aluminio - Espesor 1','Acero - Espesor 1','Aluminio - Espesor 2','Acero - Espesor 2'})
           
       %end 
       %,'Location','north','NumColumns',4
        %legend(L, {'first case', 'second case'})
    end %ele
    %disp(peso)%kg
    ylabel('Length [cm]','FontSize',12)
    xlabel('Width [cm]','FontSize',12)
   %return p1
end