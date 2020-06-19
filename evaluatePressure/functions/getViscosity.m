function mu = getViscosity(T)

% Viscosity of Ar from:
% https://www.engineeringtoolbox.com/gases-absolute-dynamic-viscosity-d_1888.html
mu_interp = [2.1 2.23 2.42 2.73 3.28 3.77 4.22 4.64 5.04] * 1e-5; % [Pa.s]
T_interp  = [0 20 50 100 200 300 400 500 600] + 273.15;           % [K]
mu = interp1(T_interp, mu_interp, T);                             % [Pa.s]

end