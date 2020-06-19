function mprickij = compute_mprickij(L_W_H, Pi, Pj, T)

% Constants
R = 8.3145;                      % Gas constant

% Model parameters
b = -1;
alpha0 = 64 / (3 * pi * (1 - 4 / b));
alpha1 = 4;
beta = 0.4;
alpha = @(p1, p2, h) (alpha0 * (2 / pi) *...
    atan(alpha1 * getKnudsen(((p1 + p2) / 2), h, T)^beta));

% Account for geometry
channel_vs_pipe_factor = @(w, h) (myCAR(h / w));
dh = @(h, w) (2 * h * w / (h + w));

Lij = L_W_H(1);
Wij = L_W_H(2);
Hij = L_W_H(3);

mprickij = channel_vs_pipe_factor(Wij, Hij) *...
    Wij * Hij^3 * Pj * (Pi - Pj) /...
    (24 * getViscosity(T) * R * T * Lij) * (...
    (Pi / Pj + 1) + 2 * (6 + alpha(Pi, Pj, Hij)) *...
    getKnudsen(Pj, dh(Hij, Wij), T) +...
    12 * (b + alpha(Pi, Pj, Hij)) / (Pi / Pj - 1) *...
    getKnudsen(Pj, dh(Hij, Wij), T)^2 *...
    log((Pi / Pj - b * getKnudsen(Pj, dh(Hij, Wij), T)) /...
    (1 - b * getKnudsen(Pj, dh(Hij, Wij), T))));

end