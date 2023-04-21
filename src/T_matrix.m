function  T=T_matrix(Lx,Ly,nx,ny,theta_a,theta_b)
  % First, lets evaluate the effective number of collumns in T
  % That is, the number of free DOFs after mapping
  %
  % The idea is the following:
  % 1) total numner of DOFs = 2*(nx+1)*(ny+1)
  %
  % 2) 3 corners are lintheta_as to C1 -> -6 dofs
  %
  % 3) the mapping among lower and upper sides of the domain reduces
  %    the number of free DOFs to 2*((nx+1)-2) = 2(nx -1)

  % 4) the same for the mapping among left and rigth sides, but with ny
  %    instead of nx
  %
  ndofs = 2*(nx+1)*(ny+1) ;
  ncols = ndofs -6 -2*(nx-1) -2*(ny-1);

  %              B2
  %    C3-----------------C4
  %      |               |
  %      |               |
  %      |               |
  %    A1|               |A2
  %      |               |
  %      |               |
  %      |               |
  %    C1-----------------C2
  %             B1
  % ------------------------------
  % Def : phi_a = Lx*theta_a*sin(theta_b)
  %       phi_b = Ly*theta_a*cos(theta_b)
  %               
  % We have the following BC 
  %
  %------------Corners------------
  % U_C2 = U_C1*exp(jphi_a)  
  % U_C4 = U_C1*exp(j(phi_a + phi_b))
  % U_C3 = U_C1*exp(jphi_b)
  % ------------Lines-------------
  % U_A2 = U_A1*exp(jphi_a)
  % U_B2 = U_B1*exp(jphi_b) 
  %-------------------------------
  % 
  
  % Fixed values
  exphia = exp(1i*theta_a*Lx);
  exphib = exp(1i*theta_b*Ly);
  exphiab = exp(1i*(theta_a*Lx+theta_b*Ly));

  % Defines T as Complex{Float64}, since it will be multiplied to theta_a (also Float)
  hint = 2*(2*(nx-1) + 2*(ny-1) + (nx-1)*(ny-1));
  VI = []; %Array{Int64}(undef,hint)
  VJ = []; %Array{Int64}(undef,hint)
  VV = []; %Array{Complex{Float64}}(undef,hint)

  % Corner nodes
  C2 = (nx+1) ;
  C3 = (nx+1)*ny + 1  ;
  C4 = (nx+1)*(ny+1)  ; 
  
  % Lets start by the corners
  col = 1;
  
  % X direction, 1-1
  VI=[VI,col];
  VJ=[VJ,col];
  VV=[VV,1.0];

  % X direction, 1-C2
  VI=[VI,2*(C2-1)+1];
  VJ=[VJ,col];
  VV=[VV,exphia];

  % X direction, ;1-C3
  VJ=[VJ,col];
  VI=[VI,2*(C3-1)+1];
  VV=[VV,exphib];

  % X direction, 1-C4
  VJ=[VJ,col];
  VI=[VI,2*(C4-1)+1];
  VV=[VV,exphiab];

  col = col+ 1;

  % Y direction, 1-1
  VI=[VI,col];
  VJ=[VJ,col];
  VV=[VV,1.0];

  % Y direction, 1-C2
  VJ=[VJ,col];
  VI=[VI,2*(C2-1)+2];
  VV=[VV,exphia];

  % Y direction, 1-C3
  VJ=[VJ,col];
  VI=[VI,2*(C3-1)+2];
  VV=[VV,exphib];

  % Y direction, 1-C4
  VJ=[VJ,col];
  VI=[VI,2*(C4-1)+2];
  VV=[VV,exphiab];

  % Now, we can map the bottom nodes
  % between [2,nx] and [C3+1,C4-1]
  node_top = C3 + 1;
  for node_bottom = 2:nx
      %@show node_bottom, node_top

      % Update the column
      col = col+ 1;

      % X direction, node_bottom - node_bottom
      VI=[VI,2*(node_bottom-1)+1];
      VJ=[VJ,col];
      VV=[VV,1.0];

      % X direction, node_bottom - node_top
      VI=[VI,2*(node_top-1)+1];
      VJ=[VJ,col];
      VV=[VV,exphib];

      % Update the column
      col = col+1;

      % Y direction, node_bottom - node_bottom
      VI=[VI,2*(node_bottom-1)+2];
      VJ=[VJ,col];
      VV=[VV,1.0];

      % Y direction, node_bottom - node_top
      VI=[VI,2*(node_top-1)+2];
      VJ=[VJ,col];
      VV=[VV,exphib];

      % Increment node top
      node_top = node_top+1; 

  end % bottom-top

  % Now, we can map the left nodes to the rigth nodes
  % between [C2+1:nx+1:C3-nx+1] and [C2+nx .. ]
  node_rigth = C2 + nx + 1;
  for node_left = C2+1:nx+1:C3-nx+1

      %@show node_left,node_rigth

      % Update the column
      col = col+1;

      % X direction, left node - left node
      VI=[VI,2*(node_left-1)+1];
      VJ=[VJ,col];
      VV=[VV,1.0];

      % X direction, left node - rigth node
      VI=[VI,2*(node_rigth-1)+1];
      VJ=[VJ,col];
      VV=[VV,exphia];

      % Update the column
      col = col+1;

      % Y direction, node_bottom - node_bottom
      VI=[VI,2*(node_left-1)+2];
      VJ=[VJ,col];
      VV=[VV,1.0];

      % Y direction, node_bottom - node_top
      VI=[VI,2*(node_rigth-1)+2];
      VJ=[VJ,col];
      VV=[VV,exphia];

      % Increment node_rigth
      node_rigth = node_rigth+(nx + 1);

  end % bottom-top

  % Finally, we can map the inner nodes
  node = C2+2;
  for c=2:nx
    for r=2:ny

      %@show node 

      % Update the column
      col = col+1;

      % X direction 
      VI=[VI,2*(node-1)+1];
      VJ=[VJ,col];
      VV=[VV,1.0];

      % Update the column
      col = col+1;

      % Y direction
      VI=[VI,2*(node-1)+2];
      VJ=[VJ,col];
      VV=[VV,1.0];

      % Increment the node
      node = node+1;

    end % r

    % we have to jump two nodes
    node = node+2;

  end % c

  % Return the operator
 
  T= full(sparse(VI,VJ,VV));
  

end
