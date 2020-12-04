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
geom_type = 'parallel_1';              % Current options: wellmixed, 
                                       % pfrlike, parallel_1/2
G = getGeometry(geom_type);            % Get reactor dimensions
nNodes = numnodes(G);                  % Number of nodes in the geometry

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

% Generate a guess that has pressure drop between consecutive nodes
P_guess = setPressures(Pin, Pout, G); 

fanon = @(P) (massFlowRate(reorder([Pin; P; Pout], G), T, G));

P_solution = fsolve(fanon, P_guess, options);

fprintf(1, 'Done.\n');

% Plot some figures
%--------------------------------
fprintf(1, 'Preparing pressure plotting...\n');

P_nodes = reorder([Pin; P_solution; Pout], G);
plotAndWritePressures(P_nodes, T, G, geom_type);

fprintf(1, 'Done.\n');

% Display flow rates at entrance
%--------------------------------
n1 = G.Edges.EndNodes(find(G.Edges.ConnectsIn == 1, 1), 1);
n2 = successors(G, n1);   % Node following inlet node

% Uncomment and adjust to choose which channel to get mass flow in
% n1 = 3; 
% n2 = 8;

firstchannel = findedge(G, n1, n2);
LWH1 = [G.Edges.Length(firstchannel);  % Dimensions of channel
    G.Edges.Width(firstchannel);
    G.Edges.Height(firstchannel)];

mprick_first = compute_mprickij(LWH1, P_nodes(n1), P_nodes(n2), T);

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
fprintf(1, 'Mass-flow rate: %1.3e kg/s\n', mprick_first);
fprintf(1, 'Volumetric flow rate: %1.3e m3/s\n', Qprick_first);
fprintf(1, 'Molecule count rate: %1.3e 1/s\n', count_first);

toc


