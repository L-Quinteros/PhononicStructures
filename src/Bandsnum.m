function [bands,phis, bigm] = Bandsnum(Lx,Ly,nx,ny,ne,nn,coord,connect...
    ,E,A,dens,x,nav,theta_a,theta_b)
  %Define the band and phis dimension
  bands = zeros(nav,length(theta_a));
  phis = zeros(2*nn,nav,length(theta_b));
  %ensamble the K and M matrix
  [bigk,bigm] = Global_KM(ne,connect,coord,E,dens,A,x);

  for i=1:length(theta_b)
    % Boundary condition matrix
    T=T_matrix(Lx,Ly,nx,ny,theta_a(i),theta_b(i));
    adT = T';    
    % The boundary condition is impose
	K = round(adT*bigk*T,15);
    M = round(adT*bigm*T,15);
    %the eigen-vectors(phi) and eigenvalues(lambda) are calculated
    [phi,lambda] = eigs(K,M,nav,'sm');
    
    eign=diag(lambda);
    %The eigenvalue are sorted
    [~,ind]=sort(eign);
    bands(:,i) = sqrt(abs(real(eign(ind))));
    % The dimension of the Phi vector is restored (including the nodes
    % in the border)
	phis(:,:,i) = T*phi(:,ind);
  end
end 
