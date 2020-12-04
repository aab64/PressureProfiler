function P = reorder(P0, G)

P = P0;
inletnode = G.Edges.EndNodes(find(G.Edges.ConnectsIn == 1, 1), 1);
outletnode = G.Edges.EndNodes(find(G.Edges.ConnectsOut == 1, 1), 2);

% Move the inlet and outlet pressures to the correct place in the array
if inletnode > 1
    P = [P0(2:inletnode); P0(1); P0(inletnode+1:end)];
end
if outletnode < height(G.Nodes)
    P = [P0(1:outletnode-1); P0(end); P0(outletnode:end-1)];
end

end