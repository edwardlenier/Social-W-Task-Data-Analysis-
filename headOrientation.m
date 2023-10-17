% Description: This function generates azimuth value (absolute value) that
% goes from 0 to 180.

% Input: data for rat1 & peer
% Output: Azimuth value (from 0 to 180)


function [absAzimuth]=headOrientation(data1,data2)

rat1_head=[data1.headX data1.headY]; % extract x,y values for head center of rat 1
rat1_nose=[data1.noseX data1.noseY]; % extract x,y value for nose of rat1
rat2_body=[data2.bodyX data2.bodyY]; % extract x,y value for body of rat2

absAzimuth=[];

for frame=1:height(data1)
    
    V=rat1_nose(frame,:)-rat1_head(frame,:);
    factor_distance=8;
    pext = rat1_head(frame,:) + V*factor_distance;
    
    v1x = pext(1) - rat1_nose(frame,1);    % vector 1 components
    v1y = pext(2) - rat1_nose(frame,2);
    d1 = sqrt(v1x^2 + v1y^2); % magnitude of vector 1
    u1 = [v1x/d1, v1y/d1]; % unit vector 1
    v2x = rat2_body(frame,1) - rat1_nose(frame,1);   % vector 2 components
    v2y = rat2_body(frame,2) - rat1_nose(frame,2);
    d2 = sqrt(v2x^2 + v2y^2);  % magnitude of vector 2
    u2 = [v2x/d2,  v2y/d2];    % inut vector 2
    
    absAzimuth(end+1) = rad2deg(acos(dot(u1,u2)));    % angle between vector 1 and vector 2

end

absAzimuth=table(absAzimuth','VariableNames',"Azimuth"); % create azimuth table 

absAzimuth=[table(data1.Time,'VariableNames',"Time") table(data1.frame,'VariableNames',"Frame") absAzimuth] % concatenate tables


end