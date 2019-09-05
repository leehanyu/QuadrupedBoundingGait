warning off

close all
clear s_y s_theta s_dx
figure
xlabel('y')
ylabel('theta')
zlabel('dx')
hold on


%% Stable IC
% plot1
y = 0.2817;  % max perturbation = - 0.03   % -0.094
theta = 0;   % theta = -4.91 to 20.78 deg  % -8.355 to 26.924
dx = 2.2;    % max perturbation = -0.249   % -0.223
thetadot = 0.4667;
Esys = m*g*y + 1/2*m*dx^2 + 1/2*J*thetadot^2;  % 31.1209

setParams(y, theta, dx, thetadot)
sim('Biomech_Project_LQR_cleanup');
Draw(s_y, s_theta, s_dx, 'b-', 1)


% change y
y = y - 0.094;
thetadot = sqrt((31.1209 - m*g*y - 1/2*m*dx^2)*2/J);
setParams(y, theta, dx, thetadot)

sim('Biomech_Project_LQR_cleanup');
Draw(s_y, s_theta, s_dx, 'b-', 1)

% % y change back
y = y + 0.094;
% change theta
theta = deg2rad(-8.355);
thetadot = sqrt((31.1209 - m*g*y - 1/2*m*dx^2)*2/J);
setParams(y, theta, dx, thetadot)

sim('Biomech_Project_LQR_cleanup');
Draw(s_y, s_theta, s_dx, 'b-', 1)

% change theta in different direction
theta = deg2rad(26.924);
thetadot = sqrt((31.1209 - m*g*y - 1/2*m*dx^2)*2/J);
setParams(y, theta, dx, thetadot)

sim('Biomech_Project_LQR_cleanup');
Draw(s_y, s_theta, s_dx, 'b-', 1)

% change theta back
theta = 0;
% change dx
dx = dx - 0.223;
thetadot = sqrt((31.1209 - m*g*y - 1/2*m*dx^2)*2/J);
setParams(y, theta, dx, thetadot)

sim('Biomech_Project_LQR_cleanup');
Draw(s_y, s_theta, s_dx, 'b-', 1)

%% Stable States
% plot2
% y = 0.1899;
% theta = 0;
% dx = 2.399;
% thetadot = sqrt((31.1209 - m*g*y - 1/2*m*dx^2)*2/J);  % 5.3997


% Fail
% y = 0.2161;
% theta = 0;
% dx = 2.414;
% thetadot = sqrt((31.1209 - m*g*y - 1/2*m*dx^2)*2/J);  % 3.1634


% load plot1.mat 




% load plot2.mat
% plot3(s_y,s_theta,s_dx, 'm-')
% plot3(s_y(1),s_theta(1),s_dx(1), 'r.', 'MarkerSize',20)

function Draw(y, theta, dx, option, enableLine)
    len = uint64(length(y));
    p2 = plot3(y(1),theta(1),dx(1), 'r.', 'MarkerSize',30);
    if enableLine
        p1 = plot3(y(len/2:len),theta(len/2:len),dx(len/2:len), option);
        p1.LineWidth = 1;
    end
end

function setParams(y, theta, dx, thetadot)
    set_param('Biomech_Project_LQR_cleanup/EOM Integration1/y0','Value',num2str(y));
    set_param('Biomech_Project_LQR_cleanup/EOM Integration1/dx0','Value',num2str(dx));
    set_param('Biomech_Project_LQR_cleanup/EOM Integration1/t0','Value',num2str(theta));
    set_param('Biomech_Project_LQR_cleanup/EOM Integration1/dt0','Value',num2str(thetadot));
end