function myZero = massFlowRate(P, T, L_W_H)

% Compute mass flow rate across segment i-j
mprickij = zeros(length(P) - 1, 1);
for i = 1:length(P) - 1
    mprickij(i) = compute_mprickij(L_W_H(i, :), P(i), P(i + 1), T);
end

% Mass flow rate should be constant across segment junctions
f = 1e10;
myZero = f * (mprickij(1:end - 1) - mprickij(2:end));

end