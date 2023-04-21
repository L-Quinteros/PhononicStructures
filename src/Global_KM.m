
function [K,M]=Global_KM(ne,connect,coord,E,dens,A,x)
    % Define vectors I, J and V for the sparse assembly
    % The number of entries will be ne * (4*4)
    % Global counter for I,J and V
    counter = 0;

    % For each element
    for ele=1:ne

       % Evaluates L, theta and dofs
       [Le, theta, dofs] = Ele_Data(ele,coord,connect);

       % Extract both E and A for this element
       Ee = E(ele,:);
       Ae = A(ele,:);
       dense = dens(ele,:);

       % Assemble the local stiffness and the local mass
       ke = Local_Stiffness(x(ele),x(ele+ne),Ee,Ae,Le);
       me = Local_Mass(x(ele),x(ele+ne),dense,Ae,Le);

       % Assemble the rotation matrix
       Re = Rotation_Matrix(theta);

       % Rotate the local element matrix to the global system
       Ke = (Re'*ke*Re);
       Me = (Re'*me*Re);
       
       % Loop to assemble I,J and V with the information of this element
       for i=1:4
           dof_i = dofs(i);
           for j=1:4
               dof_j = dofs(j);
               counter = counter + 1;
               VI(counter) = dof_i;
               VJ(counter) = dof_j;
               VK(counter) = Ke(i,j);
               VM(counter) = Me(i,j);
           end %j
      end %i
   end % ele

  % Assembly Stiffness and Mass
  K = full(sparse(VI,VJ,VK));
  M = full(sparse(VI,VJ,VM));

end
