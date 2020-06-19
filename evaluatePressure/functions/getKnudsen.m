function Kn = getKnudsen(P, h, T)

% Constants
k = 1.38064852e-23;              % Boltzmann constant [J/K]
m = 39.948e-3 / 6.022e23;        % Mass of Ar [kg]

lambda = sqrt(pi) * getViscosity(T) / (2 * P) * sqrt(2 * k * T / m);

Kn = lambda / h;

end