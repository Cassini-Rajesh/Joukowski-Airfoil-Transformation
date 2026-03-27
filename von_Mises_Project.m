%% Von Mises Computer Program Project

% Calculate Circle Center and Radius from Thickness and Camber Ratio
camber_ratio = 0.05;                                % Camber ratio
beta_input = atan(2*camber_ratio);                  % beta value for Joukowski transform
thickness_ratio = 0.15;                             % Thickness Ratio
epsilon = thickness_ratio/1.299;                    % epsilon for center circle
b = 1;                                              % b value for Joukowski transform 
mu = (-epsilon*b) + 1i*(b*tan(beta_input))          % Center circle
a = abs(b - mu);                                    % Circle radius

% Geometry of Circle to be Transformed
theta_TE = angle(b - mu);                           % Theta at trailing edge
theta = linspace(theta_TE, theta_TE + 2*pi, 900); 
zeta = mu + a*exp(1i*theta);                   

% Plotting Circle
figure                                       
plot(real(zeta),imag(zeta), 'b-')
hold on
plot(real(mu), imag(mu), 'b*', 'MarkerSize', 10, 'LineWidth', 2); 
joukowski_zeros = [b, -b];

plot(real(joukowski_zeros), imag(joukowski_zeros), 'bo', 'MarkerSize', 8, 'LineWidth', 2);
hold off; 
axis equal
grid on;
xlabel('x')
ylabel('iy')
title('Geometry of Circle to be Transformed (Joukowski)')

% Joukowski Airfoil Transformation
z = zeta + (b^2 ./ zeta);                           % Airfoil in Z plane
xLE = min(real(z));                                 % Leading edge in real plane
xTE = max(real(z));                                 % Trailing edge in real plane
c = xTE - xLE;                                      % Chord length
xc = (real(z) - xLE) / c;                           % x/c
yc = imag(z) / c;                                   % y/c

figure                                              % Figure 2
plot(xc,yc)                                         % Plot airfoil
xlim([0 1])
axis equal
grid on;
xlabel("Scaled Chord Length Position (x/c)")
ylabel('Scaled Thickness (y/c)')
title('Scaled Joukowski Airfoil')

% Velocity Destribution
beta_geom = -theta_TE;                              % beta for trailing edge

% Angle of Attack = 0
alpha = (pi/180)*0;      

% Calculate v/vinf
V_s_Vinf = (2*abs ( (sin(alpha+beta_geom)) - (sin(alpha-theta)) ) );
dz_dzeta = (abs(1-(b^2 ./ zeta.^2)));
V_Vinf = V_s_Vinf ./ dz_dzeta;

% Fix the trailing edge (TE) points
V_TE = (b/a) * abs(cos(alpha + beta_geom));         % kutta condition
V_Vinf(1) = V_TE;                                   % first point
V_Vinf(end) = V_TE;                                 % last point

% Plot
figure
plot(xc,V_Vinf)
xlim([0 1])
ylim([0 1.6])
xlabel('Chord Lengh Ratio (x/c)')
ylabel('Local Velocity Ratio (V/Vinf)')
title('Nondimensional Velocity Ratio Across Airfoil (AoA = 0)')
grid on;

% Angle of Attack = 5
alpha = (pi/180)*5;

% Calculate V/Vinf
V_s_Vinf = (2*abs ( (sin(alpha+beta_geom)) - (sin(alpha-theta)) ) );
dz_dzeta = (abs(1-(b^2 ./ zeta.^2)));
V_Vinf = V_s_Vinf ./ dz_dzeta;
V_TE = (b/a) * abs(cos(alpha + beta_geom));          % kutta condition
V_Vinf(1) = V_TE;                                    % first point   
V_Vinf(end) = V_TE;                                  % last point

% Plot
figure
plot(xc,V_Vinf)
xlim([0 1])
ylim([0 2])
xlabel('Chord Lengh Ratio (x/c)')
ylabel('Local Velocity Ratio (V/Vinf)')
title('Nondimensional Velocity Ratio Across Airfoil (AoA = 5)')
grid on;

% Angle of Attack = 10
alpha = (pi/180)*10;

% Calculate V/Vinf
V_s_Vinf = (2*abs ( (sin(alpha+beta_geom)) - (sin(alpha-theta)) ) );
dz_dzeta = (abs(1-(b^2 ./ zeta.^2)));
V_Vinf = V_s_Vinf ./ dz_dzeta;
V_TE = (b/a) * abs(cos(alpha + beta_geom));            % kutta condition
V_Vinf(1) = V_TE;                                      % first point
V_Vinf(end) = V_TE;                                    % last point

% Plot
figure
plot(xc,V_Vinf)
xlim([0 1])
ylim([0 2.5])
xlabel('Chord Lengh Ratio (x/c)')
ylabel('Local Velocity Ratio (V/Vinf)')
title('Nondimensional Velocity Ratio Across Airfoil (AoA = 10)')
grid on;

% Angle of Attack = 15
alpha = (pi/180)*15;

% Calculate V/Vinf
V_s_Vinf = (2*abs ( (sin(alpha+beta_geom)) - (sin(alpha-theta)) ) );
dz_dzeta = (abs(1-(b^2 ./ zeta.^2)));
V_Vinf = V_s_Vinf ./ dz_dzeta;
V_TE = (b/a) * abs(cos(alpha + beta_geom));             % Kutta condition
V_Vinf(1) = V_TE;                                       % First point
V_Vinf(end) = V_TE;                                     % Last point

% Plot
figure
plot(xc,V_Vinf)
xlim([0 1])
ylim([0 3.5])
xlabel('Chord Lengh Ratio (x/c)')
ylabel('Local Velocity Ratio (V/Vinf)')
title('Nondimensional Velocity Ratio Across Airfoil (AoA = 15)')
grid on;

% Von Mises Airfoil Transformation

% R = 1.111, UR=-0.072, UI=0.290 from von mises check case
a = 1.111;                                      
mu = -0.072 + 1i*0.290;     
zT = 1.0; 

% Geometry of Circle to be Transformed
theta_TE = angle(zT - mu); 
theta = linspace(theta_TE, theta_TE + 2*pi, 400); 
zeta = mu + a*exp(1i*theta);       

% Kutta condition
beta_geom = -theta_TE;

% Von Mises Circle
figure
plot(real(zeta), imag(zeta), 'b-') 
hold on;
plot(real(mu), imag(mu), 'b*', 'MarkerSize', 10, 'LineWidth', 2);

z2 = -1.0 + 0i;
z3 = 0.370 - 0.471i;
z4 = -0.370 + 0.471i;
vm_zeros = [zT, z2, z3, z4];

plot(real(vm_zeros), imag(vm_zeros), 'bo', 'MarkerSize', 8, 'LineWidth', 2);
hold off;
axis equal
grid on;
xlabel('x')
ylabel('iy')
title('Geometry of Circle (von Mises)')

% zeta values from Von Mises check case
z2 = -1.0 + 0i;
z3 = 0.370 - 0.471i;
z4 = -0.370 + 0.471i;

% Calculate c1,c2,c3 coefficients
c1 = zT^2 - z2*(z3+z4) - z3*z4;
c2 = 0.5 * (zT*(z2*(z3+z4) + z3*z4) + z2*z3*z4);
c3 = (-1/3) * (zT*z2*z3*z4);

% Von Mises Transformation
z = zeta + c1./zeta + c2./(zeta.^2) + c3./(zeta.^3);

% x/c and y/c normalization
xLE = min(real(z));                             
xTE = max(real(z));                             
c = xTE - xLE;                                  
xc = (real(z) - xLE) / c;                       
yc = imag(z) / c;   

coords = [xc(:) yc(:)];

fid = fopen('vonmises.dat','w');
fprintf(fid, 'vonMises_airfoil\n');           % title line
fprintf(fid, '% .6f  % .6f\n', coords.');     % x  y lines
fclose(fid);

% Plotting
figure
plot(xc,yc)                                     
axis equal
grid on;
xlabel("Scaled Chord Length Position (x/c)")
ylabel('Scaled Thickness (y/c)')
title('Scaled von Mises Airfoil')

% Velocity Distribution

% Angle of Attack = 5
alpha = (pi/180)*5;

% Numerator for V/Vinf
V_s_Vinf = (2*abs ( (sin(alpha+beta_geom)) - (sin(alpha-theta)) ) );

% New denominator for V/Vinf
dz_dzeta_factored = (1 - zT./zeta) .* (1 - z2./zeta) .* (1 - z3./zeta) .* (1 - z4./zeta);
dz_dzeta = abs(dz_dzeta_factored);

% V/Vinf calculation
V_Vinf = V_s_Vinf ./ dz_dzeta;

% Numerator for Kutta condition
V_TE_numerator = 2 * abs(cos(alpha + beta_geom)) / a;

% Denominator for Kutta condition
zT_pp = (1/zT) * (1 - z2/zT) * (1 - z3/zT) * (1 - z4/zT);
V_TE_denominator = abs(zT_pp);

% Kutta condition
V_TE = V_TE_numerator / V_TE_denominator;

% First and Last Elements
V_Vinf(1) = V_TE;     
V_Vinf(end) = V_TE;   

% Plotting
figure
plot(xc,V_Vinf)
xlim([0 1])
ylim([0 2.4]) 
xlabel('Chord Lengh Ratio (x/c)')
ylabel('Local Velocity Ratio (V/Vinf)')
title('von Mises Velocity Distribution (AoA = 5)')
grid on;

% Angle of Attack = 0
alpha = (pi/180)*0;

% Numerator for V/Vinf
V_s_Vinf = (2*abs ( (sin(alpha+beta_geom)) - (sin(alpha-theta)) ) );

% New denominator for V/Vinf
dz_dzeta_factored = (1 - zT./zeta) .* (1 - z2./zeta) .* (1 - z3./zeta) .* (1 - z4./zeta);
dz_dzeta = abs(dz_dzeta_factored);

% V/Vinf calculation
V_Vinf = V_s_Vinf ./ dz_dzeta;

% Numerator for Kutta condition
V_TE_numerator = 2 * abs(cos(alpha + beta_geom)) / a;

% Denominator for Kutta condition
zT_pp = (1/zT) * (1 - z2/zT) * (1 - z3/zT) * (1 - z4/zT);
V_TE_denominator = abs(zT_pp);

% Kutta condition
V_TE = V_TE_numerator / V_TE_denominator;

% First and Last Elements
V_Vinf(1) = V_TE;     
V_Vinf(end) = V_TE;   

% Plotting
figure
plot(xc,V_Vinf)
xlim([0 1])
ylim([0 2.4]) 
xlabel('Chord Lengh Ratio (x/c)')
ylabel('Local Velocity Ratio (V/Vinf)')
title('von Mises Velocity Distribution (AoA = 0)')
grid on;

% Angle of Attack = 10
alpha = (pi/180)*10;

% Numerator for V/Vinf
V_s_Vinf = (2*abs ( (sin(alpha+beta_geom)) - (sin(alpha-theta)) ) );

% New denominator for V/Vinf
dz_dzeta_factored = (1 - zT./zeta) .* (1 - z2./zeta) .* (1 - z3./zeta) .* (1 - z4./zeta);
dz_dzeta = abs(dz_dzeta_factored);

% V/Vinf calculation
V_Vinf = V_s_Vinf ./ dz_dzeta;

% Numerator for Kutta condition
V_TE_numerator = 2 * abs(cos(alpha + beta_geom)) / a;

% Denominator for Kutta condition
zT_pp = (1/zT) * (1 - z2/zT) * (1 - z3/zT) * (1 - z4/zT);
V_TE_denominator = abs(zT_pp);

% Kutta condition
V_TE = V_TE_numerator / V_TE_denominator;

% First and Last Elements
V_Vinf(1) = V_TE;     
V_Vinf(end) = V_TE;   

% Plotting
figure
plot(xc,V_Vinf)
xlim([0 1])
ylim([0 2.8]) 
xlabel('Chord Lengh Ratio (x/c)')
ylabel('Local Velocity Ratio (V/Vinf)')
title('von Mises Velocity Distribution (AoA = 10)')
grid on;

% Angle of Attack = 15
alpha = (pi/180)*15;

% Numerator for V/Vinf
V_s_Vinf = (2*abs ( (sin(alpha+beta_geom)) - (sin(alpha-theta)) ) );

% New denominator for V/Vinf
dz_dzeta_factored = (1 - zT./zeta) .* (1 - z2./zeta) .* (1 - z3./zeta) .* (1 - z4./zeta);
dz_dzeta = abs(dz_dzeta_factored);

% V/Vinf calculation
V_Vinf = V_s_Vinf ./ dz_dzeta;

% Numerator for Kutta condition
V_TE_numerator = 2 * abs(cos(alpha + beta_geom)) / a;

% Denominator for Kutta condition
zT_pp = (1/zT) * (1 - z2/zT) * (1 - z3/zT) * (1 - z4/zT);
V_TE_denominator = abs(zT_pp);

% Kutta condition
V_TE = V_TE_numerator / V_TE_denominator;

% First and Last Elements
V_Vinf(1) = V_TE;     
V_Vinf(end) = V_TE;   

% Plotting
figure
plot(xc,V_Vinf)
xlim([0 1])
ylim([0 4]) 
xlabel('Chord Lengh Ratio (x/c)')
ylabel('Local Velocity Ratio (V/Vinf)')
title('von Mises Velocity Distribution (AoA = 15)')
grid on;