function plot_truss(nc,x)
        type = 1;
        nx = nc;
        ny = nc;
        Lc = 0.025*nc;
        Lx = Lc;
        Ly = Lc;
        S=Symmetry_Map_FBZ(nc,type);
        nxred = size(S,2);
        % THE plates are not counted in the opt-process
		xm = x(1:nxred);
		xa = x(nxred+1:2*nxred);
		
    	x_mat = S*xm;
        x_area = S*xa;
		
		[nn,numele,coord,connect]=Truss_mesh(Lx,nx,Ly,ny,type);		        
		Plot_Structure(numele,connect,coord,x_area,x_mat)
end 