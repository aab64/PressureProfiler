clc, clear, close all

% Plot defaults
set(0,'defaultAxesFontSize',10)
set(0, 'DefaultLineLineWidth', 2);

tic
fprintf(1, 'Started...\n');

% Add functions to path
%--------------------------------
addpath(genpath([pwd '/functions']));

% Reactor geometry
%--------------------------------
geom_type = 'wellmixed';               % Current options: wellmixed/pfrlike
L_W_H = getGeometry(geom_type);        % Get reactor dimensions
nSegments = length(L_W_H) - 1;         % Number of segments in the geometry

L23 = L_W_H(1, 1);
h23 = L_W_H(1, 3);
w23 = L_W_H(1, 2);

% Conditions
%--------------------------------
Pin = 4e5;                             % Starting pressure [Pa]
Pout = 1e-12 * 1e5;                    % Final pressure [Pa]
T = 273.15 + 400;                      % Temperature [K]

% Solve for consistent conditions
%--------------------------------
fprintf(1, 'Solving for P...');

options = optimoptions('fsolve', 'Display', 'iter-detailed', 'TolFun',...
    1e-40, 'TolX', 1e-40);

P_guess = fliplr(linspace(10 * Pout, 0.9 * Pin, nSegments))';

fanon = @(P) (massFlowRate([Pin; P; Pout], T, L_W_H));

P_solution = fsolve(fanon, P_guess, options);

fprintf(1, 'Done.\n');

% Plot some figures
%--------------------------------
fprintf(1, 'Preparing pressure plotting...\n');

plotAndWritePressures([Pin; P_solution; Pout], T, L_W_H, geom_type);

fprintf(1, 'Done.\n');

% Display flow rates at entrance
%--------------------------------
mprick_first = compute_mprickij(L_W_H(1, :), Pin, P_solution(1), T);

% rho = n * N_A * m / V
% Ideal gas law in terms of Boltzmann constants:
% P * V = n * N_A * k * T
% put it together:
% rho = P * V * m / (V * k * T) = P * m / (k * T)
k = 1.38064852e-23;                    % Boltzmann constant [J/K]
m = 39.948e-3 / 6.022e23;              % Mass of Ar [kg]
rho = Pin * m / (k * T);
Qprick_first = mprick_first / rho;
count_first = mprick_first / m;

fprintf(1, 'Overview:\n');
fprintf(1, '=========\n\n');
fprintf(1, 'Mass-flow rate (section 23): %1.3e kg/s\n', mprick_first);
fprintf(1, 'Volumetric flow rate (at 2): %1.3e m3/s\n', Qprick_first);
fprintf(1, 'Molecule count rate (s. 23): %1.3e 1/s\n', count_first);

toc


