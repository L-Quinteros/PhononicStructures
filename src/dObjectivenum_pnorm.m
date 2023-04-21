
function dnumam=dObjectivenum_pnorm(S,x,p,A,E,dens,n,nn,ne,coord,connect,...
                                Lx,Ly,nx,ny,nav,theta_a,theta_b,nxred)
    %Expand "x" 
    x_expandedm = S*x(1:nxred);
    x_expandeda = S*x(nxred+1:2*nxred);
    x_expanded = [x_expandedm;x_expandeda];
    
    %x_expanded = x
    
    [band,bandphi, M] = Bandsnum(Lx,Ly,nx,ny,ne,nn,coord,connect,E,A,dens,x_expanded,nav,theta_a,theta_b);
    omega = band;
    phi = bandphi; 
    N_band = length(band(1,:));
    %bandphi constains the informacion [ndofs,nav,length(k)]
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
    
    omegan = Matrixnorm(omega(1:n,:),p);
   
    fomegan = omegan^(1-p);    
    omegan1 = 1.0 / Matrixnorm(1 ./ omega(n+1:nav,:),p);
    fomegan1 = omegan1^(1+p);
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
        % sum of the omegan in order to calculate eq (4)
        for j= 1: N_band
            for i=1:n
                %extract the local eigenvector (m)
                phidofs = phi(dofs,i,j);
                domegaijdxm_m = dot(phidofs,(dKdxm-((omega(i,j))^(2))*dMdxm)*phidofs)/(2*omega(i,j)*normal_mass(i,j)) ;
                domegaijdxm_a = dot(phidofs,(dKdxa-((omega(i,j))^(2))*dMdxa)*phidofs)/(2*omega(i,j)*normal_mass(i,j));
                % eigen value derivative
                fomegan_k_m = (omega(i,j)^(p-1))*domegaijdxm_m ;
                fomegan_k_a = (omega(i,j)^(p-1))*domegaijdxm_a;
                domegan_k_m = domegan_k_m + fomegan_k_m;
                domegan_k_a = domegan_k_a + fomegan_k_a;
            end %i
        end %j
        
        % sum of the omegan+1 in order to calculate eq (5)
        for j= 1: N_band
            for i=(n+1):(nav)
                %extract the local eigenvector (m)
                phidofs = phi(dofs,i,j);
                domegaijdxm_m = dot(phidofs,(dKdxm-(omega(i,j)^2)*dMdxm)*phidofs)/(2*omega(i,j)*normal_mass(i,j)) ;
                domegaijdxm_a = dot(phidofs,(dKdxa-(omega(i,j)^2)*dMdxa)*phidofs)/(2*omega(i,j)*normal_mass(i,j)) ;
                % eigen value derivative
                fomegan1_k_m = (omega(i,j)^(-p-1))*domegaijdxm_m;
                fomegan1_k_a = (omega(i,j)^(-p-1))*domegaijdxm_a;
                domegan1_k_m = domegan1_k_m + fomegan1_k_m;
                domegan1_k_a = domegan1_k_a + fomegan1_k_a;
            end %i
        end %j
        %Material
        %omegan derivative
        domegandx_m(k,1) = fomegan*domegan_k_m;
        %omegan+1 derivative
        domegan1dx_m(k,1) = fomegan1*domegan1_k_m;
        %deltaomegan derivative
        ddeltaomegadx_m(k,1)= fomegan1*domegan1_k_m - fomegan*domegan_k_m;
        %Area 
        %omegan derivative
        domegandx_a(k,1) = fomegan*domegan_k_a;
        %omegan+1 derivative
        domegan1dx_a(k,1) = fomegan1*domegan1_k_a;
        %deltaomegan derivative
        ddeltaomegadx_a(k,1)= fomegan1*domegan1_k_a - fomegan*domegan_k_a;
    end % elements 
    material = S'*real(ddeltaomegadx_m);
    area = S'*real(ddeltaomegadx_a);
    dnumam = [material;area];
    %,domegandx,domegan1dx%,omegan,omegan1
    %return domegandx%,omegan,omegan1
end
