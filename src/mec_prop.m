function [rho,E,A]=mec_prop(ne)
% Use the aluminum properties in material 1 and the tungsten as 2.
% Yound modulus [Pa]

  ym1 = 70e9;
  ym2 = 411e9;
% Density [kg/m3]

  d1 = 2.7e3;
  d2 = 19.3e3;
% Cross section area [m2], in this case a circular cross section is 
% study wich diameters varies form 4[mm] to 8[mm].
 
  A1 = pi*(0.004^2)/4;
  A2 = pi*(0.008^2)/4;
  
  
  Area1          = A1 ;% [m²]
  Young_Modulus1 = ym1 ;     % [Pa]
  Density1       = d1   ;  % [Kg/m³]
  Area2          = A2 ; % [m²]
  Young_Modulus2 = ym2 ;    % [Pa]
  Density2       = d2   ;   % [Kg/m³]
  E = ones(ne,2);
  A = ones(ne,2);
  rho = ones(ne,2);
  E(:,1) = Young_Modulus1*ones(ne,1);
  rho(:,1) = Density1*ones(ne,1);
  A(:,1) = Area1*ones(ne,1);
  E(:,2) = Young_Modulus2*ones(ne,1);
  rho(:,2) = Density2*ones(ne,1);
  A(:,2) = Area2*ones(ne,1);
end 