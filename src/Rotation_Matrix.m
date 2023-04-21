function [R]=Rotation_Matrix(theta)
        %Rotation matrix that rotate each element, in this case 
        % the problem can be rotated in 0°, 45°,90° and 135°
        c = cos(theta);
        s = sin(theta);
        R=[c -s 0  0
           s  c 0  0
           0  0 c -s
           0  0 s  c];
end