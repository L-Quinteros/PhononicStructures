function [delta]=Objective_pnorm(n,Lx,Ly,nx,ny,ne,coord,connect,E,A,dens,x,nxred,S,P,nav,theta_a,theta_b)

    xm = x(1:nxred);
    xa = x(nxred+1:2*nxred);
    % We are working with a restricted set of design variables
    x_expandedm = S*xm;
    x_expandeda = S*xa;
    x_expanded = [x_expandedm;x_expandeda];
    bands =  Bands(Lx,Ly,nx,ny,ne,coord,connect,E,A,dens,x_expanded,nav,theta_a,theta_b);
    [delta,~,~]=obj_pnorm(bands,n,nav,P);
end