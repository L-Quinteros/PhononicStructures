function [delta]=Objective(n,Lx,Ly,nx,ny,ne,nn,coord,connect,E,A,dens,x,nxred,S,nav,theta_x,theta_y)
    %This objective function does not considerer a proper treatment for the
    % non-differentiation of eigenvalues
    xm = x(1:nxred);
    xa = x(nxred+1:2*nxred);
    % We are working with a restricted set of design variables
    x_expandedm = S*xm;
    x_expandeda = S*xa;
    x_expanded = [x_expandedm;x_expandeda];
    %Band diagram calculation
    bands =  Bands(Lx,Ly,nx,ny,ne,coord,connect,E,A,dens,x_expanded,nav,theta_x,theta_y);
    %The maximum and minimum calculation
    d1 = max(max(bands(1:n,:)));
    d2 = min(min(bands(n+1:nav,:))); 
    delta = d2-d1;
end