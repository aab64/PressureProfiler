function myZero = massFlowRate(P, T, G)

mprickij = zeros(length(P), 1);
for i = 1:numedges(G)
    % Channel info
    ni = G.Edges.EndNodes(i, 1);      % start node
    nj = G.Edges.EndNodes(i, 2);      % end node
    LWH = [G.Edges.Length(i);
        G.Edges.Width(i);
        G.Edges.Height(i)];           % segment dimensions
    
    % Compute mass flow rate across segment
    mdot_j1_j2 = compute_mprickij(LWH, P(ni), P(nj), T);
    
    % Add to node sums (inflow - outflow)
    mprickij(ni) = mprickij(ni) - mdot_j1_j2;
    mprickij(nj) = mprickij(nj) + mdot_j1_j2;
end

% Trim off inlet and outlet nodes as pressures there are known
inletnode = G.Edges.EndNodes(find(G.Edges.ConnectsIn == 1, 1), 1);
outletnode = G.Edges.EndNodes(find(G.Edges.ConnectsOut == 1, 1), 2);
mprickij([inletnode, outletnode]) = [];

% Mass flow rate should be constant across segment junctions
f = 1e10;
myZero = f * mprickij;

end