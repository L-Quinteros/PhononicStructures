function d=dObjectiveana(n,Lx,Ly,nx,ny,ne,nn,coord,connect,E,A,dens,x,nxred,S,nav,theta_a,theta_b)
    d = zeros(length(x),1);
    delta=1e-5;
    for i =1:length(x)
        xi0=x(i);
        x(i)=xi0+delta;
        dfor=Objective(n,Lx,Ly,nx,ny,ne,nn,coord,connect,E,A,dens,x,nxred,S,nav,theta_a,theta_b);
        
        x(i)=xi0-delta;
        dbac=Objective(n,Lx,Ly,nx,ny,ne,nn,coord,connect,E,A,dens,x,nxred,S,nav,theta_a,theta_b);
        d(i)=(dfor-dbac)/(2*delta);
        x(i)=xi0;
    end 
end