
function bands=Bands(Lx,Ly,nx,ny,ne,coord,connect,E,A,dens,x,nav,theta_x,theta_y)
  % Bands alltogether
  bands = zeros(nav,length(theta_x));
  
  [bigk,bigm] = Global_KM(ne,connect,coord,E,dens,A,x);

  for i=1:length(theta_y)
    T=T_matrix(Lx,Ly,nx,ny,theta_x(i),theta_y(i));
    adT = T';
	K = round(adT*bigk*T,15);
    M = round(adT*bigm*T,15);		
	[~,lambda] = eigs(K,M,nav,'sm');
    [~,idx]=sort(diag(lambda));
	bands(:,i) = sqrt((real(diag(lambda(idx,idx)))));
  end  
end  