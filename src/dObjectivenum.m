
function dnumam=dObjectivenum(S,x,A,E,dens,n,nn,ne,coord,connect,...
                                Lx,Ly,nx,ny,nav,theta_x,theta_y,nxred)
                                                 
    %Analytical derivatives are calculated in this section.
    
    %Expand "x" of design variables 
    x_expandedm = S*x(1:nxred);
    x_expandeda = S*x(nxred+1:2*nxred);
    x_expanded = [x_expandedm;x_expandeda];
    
  
    % The band diagram, the matrix M and the eigen-vector are needed, then
    % a new function is created (similar to Bands) that do exactly the same
    % but in order to increase the computational eficiency a new one is
    % programm
    [band,bandphi, M] = Bandsnum(Lx,Ly,nx,ny,ne,nn,coord,connect,E,A,dens,x_expanded,nav,theta_x,theta_y);
    
    %Frequency 
    omega = band;
    %Eigen-vectors
    phi = bandphi; 
    
    N_band = length(band(1,:));
    
    % Mass normalization 
    normal_mass = zeros(nav,N_band);
    for j=1:N_band
        for i=1:nav  
            normal_mass(i,j) = phi(:,i,j)'*M*phi(:,i,j);
        end
    end  
    
    %We have to calculate the derivatives in function of m and a
    %Material
    ddeltaomegadx_m  = zeros(ne,1);
    domegandx_m = zeros(ne,1);
    domegan1dx_m = zeros(ne,1);
    %Area 
    ddeltaomegadx_a  = zeros(ne,1);
    domegandx_a  = zeros(ne,1);
    domegan1dx_a = zeros(ne,1);
    %Calculating the factors
    [~,max_indx]=max(band(n,:));
    [~,min_indx]=min(band(n+1,:));
    % Main lopp (elements)
    for k=1:ne
        % Element properties
        dense = dens(k,:);
        Ae = A(k,:);
        Ee = E(k,:);
        [Le, theta, dofs]= Ele_Data(k,coord,connect);
        % Assemble the local stiffness and mass
        ke_m = dLocal_Stiffnessdxm(x_expanded(k),x_expanded(k+ne),Ee,Ae,Le);
        ke_a = dLocal_Stiffnessdxa(x_expanded(k),x_expanded(k+ne),Ee,Ae,Le);
        me_m = dLocal_Massdxm(x_expanded(k),x_expanded(k+ne),dense,Ae,Le);
        me_a = dLocal_Massdxa(x_expanded(k),x_expanded(k+ne),dense,Ae,Le);
        % Assemble the rotation matrix
        Re = Rotation_Matrix(theta);
        % Rotate the local element matrix to the global system
        K0_m = (Re'*ke_m*Re);
        M0_m = (Re'*me_m*Re);
        K0_a = (Re'*ke_a*Re);
        M0_a = (Re'*me_a*Re);
        % M and K Derivatives in function of x
        dMdxm = M0_m;
        dKdxm = K0_m;
        dMdxa = M0_a;
        dKdxa = K0_a;
        % calculate sensitivity in function of the element
        domegan_k_m = 0.0+1j*0;
        domegan1_k_m = 0.0+1j*0;
        domegan_k_a = 0.0+1j*0;
        domegan1_k_a = 0.0+1j*0;
        % sum of the omegan 
        j = max_indx;
        i = n;
        %for j= 1: N_band
        %    for i=1:n
                %extract the local eigenvector (m)
                phidofs = phi(dofs,i,j);
                domegaijdxm_m = dot(phidofs,(dKdxm-((omega(i,j))^(2))*dMdxm)*phidofs)/(2*omega(i,j)*normal_mass(i,j));
                domegaijdxm_a = dot(phidofs,(dKdxa-((omega(i,j))^(2))*dMdxa)*phidofs)/(2*omega(i,j)*normal_mass(i,j));
                % eigen value derivative
                fomegan_k_m = domegaijdxm_m ;
                fomegan_k_a = domegaijdxm_a;
                domegan_k_m = domegan_k_m + fomegan_k_m;
                domegan_k_a = domegan_k_a + fomegan_k_a;
        %    end %i
        %end %j
        
        % sum of the omegan+1 
        j = min_indx;
        i = n+1;
        %for j= 1: N_band
        %    for i=(n+1):(nav)
                %extract the local eigenvector (m)
                phidofs = phi(dofs,i,j);
                domegaijdxm_m = dot(phidofs,(dKdxm-(omega(i,j)^2)*dMdxm)*phidofs)/(2*omega(i,j)*normal_mass(i,j)) ;
                domegaijdxm_a = dot(phidofs,(dKdxa-(omega(i,j)^2)*dMdxa)*phidofs)/(2*omega(i,j)*normal_mass(i,j)) ;
                % eigen value derivative
                fomegan1_k_m = domegaijdxm_m;
                fomegan1_k_a = domegaijdxm_a;
                domegan1_k_m = domegan1_k_m + fomegan1_k_m;
                domegan1_k_a = domegan1_k_a + fomegan1_k_a;
        %    end %i
        %end %j
        %Material
        %omegan derivative
        domegandx_m(k,1) = domegan_k_m;
        %omegan+1 derivative
        domegan1dx_m(k,1) = domegan1_k_m;
        %deltaomegan derivative
        ddeltaomegadx_m(k,1)= domegan1_k_m - domegan_k_m;
        %Area 
        %omegan derivative
        domegandx_a(k,1) = domegan_k_a;
        %omegan+1 derivative
        domegan1dx_a(k,1) = domegan1_k_a;
        %deltaomegan derivative
        ddeltaomegadx_a(k,1)= domegan1_k_a - domegan_k_a;
    end % elements 
    material = S'*real(ddeltaomegadx_m);
    area = S'*real(ddeltaomegadx_a);
    dnumam = [material;area];
end
