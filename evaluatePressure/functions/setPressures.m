function Pact = setPressures(Pin, Pout, G)

% Get all channel paths connecting the inlet and outlet nodes
inletnode = G.Edges.EndNodes(find(G.Edges.ConnectsIn == 1, 1), 1);
outletnode = G.Edges.EndNodes(find(G.Edges.ConnectsOut == 1, 1), 2);
paths = pathbetweennodes(adjacency(G), inletnode, outletnode);

% Interpolate between the pressure end points for each path
for path = 1:length(paths)
    Pvals{path} = linspace(Pin, Pout, length(paths{path}));
end

% Assign average pressures to each node
Pact = zeros(numnodes(G), 1);
for i = 1:numnodes(G)
    ctr = 1;
    for path = 1:length(paths)
        i1 = find(paths{path} == i, 1);
        if ~isempty(i1)
            Pact(i) = Pact(i) + Pvals{path}(i1);
            ctr = ctr + 1;
        end
    end
    Pact(i) = Pact(i) / ctr;
end

% Remove the end points
Pact([inletnode, outletnode]) = [];

end