function [L, theta, dofs]=Ele_Data(ele,coord,connect)

    % recover the nodes
    node1 = connect(ele,1);
    node2 = connect(ele,2);
    % we need both x2-x1 and y2-y1
    dx = coord(node2,1) - coord(node1,1);
    dy = coord(node2,2) - coord(node1,2);

    % Evaluates L for this element
    L = sqrt(dx^2 + dy^2);

    % Evaluates theta for this element. This usage of atan
    % is equivalent to the usual atan2 command used in matlab.
    theta = atan(dy/dx);

    % Find the global DOFs for this element
    dofs = [2*(node1-1)+1 2*(node1-1)+2 2*(node2-1)+1 2*(node2-1)+2];
            

end