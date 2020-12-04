function G = getGeometry(geom_type)

id = geom_type;

switch id
    case 'wellmixed'
        disp('ID: Well-mixed')
        % Channel lengths (m)
        L23 = 500e-6;
        L34 = 70e-6;
        L44 = 180e-6;
        L56 = L23;
        L67 = 21e-3;
        Lij = [L23; L34; L44; L34; L56; L67];
        
        % Channel heights (m)
        h23 = 100e-9;
        h34 = 100e-9;
        h44 = 100e-9;
        h56 = 100e-9;
        h67 = 60e-6;
        Hij = [h23; h34; h44; h34; h56; h67];
        
        % Channel widths (m)
        w23 = 10e-6;
        w34 = 10e-6;
        w44 = 120e-6;
        w56 = 10e-6;
        w67 = 150e-6;
        Wij = [w23; w34; w44; w34; w56; w67];
        
        % Channel connectivity (channel connects start node to end node)
        C = zeros(length(Lij), 2);
        C(:, 1) = [1, 2, 3, 4, 5, 6]; % Start node
        C(:, 2) = [2, 3, 4, 5, 6, 7]; % End node
        
        % Store this info as a directed graph
        G = digraph(C(:, 1), C(:, 2), Lij * 1e3);
        G.Edges.Length(findedge(G,C(:, 1), C(:, 2))) = Lij;
        G.Edges.Width(findedge(G,C(:, 1), C(:, 2))) = Wij;
        G.Edges.Height(findedge(G,C(:, 1), C(:, 2))) = Hij;

    case 'pfrlike'
        disp('ID: PFR-like')
        % Channel lengths (m)
        L23 = 500e-6;
        L34 = 70e-6;
        L44 = 216e-6;
        L56 = L23;
        L67 = 21e-3;
        Lij = [L23; L34; L44; L34; L56; L67];
        
        % Channel heights (m)
        h23 = 100e-9;
        h34 = 100e-9;
        h44 = 100e-9;
        h56 = 100e-9;
        h67 = 60e-6;
        Hij = [h23; h34; h44; h34; h56; h67];
        
        % Channel widths (m)
        w23 = 10e-6;
        w34 = 10e-6;
        w44 = 10e-6;
        w56 = 10e-6;
        w67 = 150e-6;
        Wij = [w23; w34; w44; w34; w56; w67];
        
        % Channel connectivity (channel connects start node to end node)
        C = zeros(length(Lij), 2);
        C(:, 1) = [1, 2, 3, 4, 5, 6]; % Start node
        C(:, 2) = [2, 3, 4, 5, 6, 7]; % End node
        
        % Store this info as a directed graph
        G = digraph(C(:, 1), C(:, 2), Lij * 1e3);
        G.Edges.Length(findedge(G,C(:, 1), C(:, 2))) = Lij;
        G.Edges.Width(findedge(G,C(:, 1), C(:, 2))) = Wij;
        G.Edges.Height(findedge(G,C(:, 1), C(:, 2))) = Hij;
        
    case 'parallel_1'
        disp('ID: Parallel_1')
        % Channel lengths (m)
        L23 = 500e-6;
        L34 = 70e-6;
        L44 = 180e-6;
        L56 = L23;
        L67 = 21e-3;
        Lij = [L23; L34; L44; 
            L44/3; L44/3; L44/3; % Add one copy of the L44 segment
            L34; L56; L67];
        
        % Channel heights (m)
        h23 = 100e-9;
        h34 = 100e-9;
        h44 = 100e-9;
        h56 = 100e-9;
        h67 = 60e-6;
        Hij = [h23; h34; h44; 
            h44; h44; h44;
            h34; h56; h67];
        
        % Channel widths (m)
        w23 = 10e-6;
        w34 = 10e-6;
        w44 = 120e-6;
        w56 = 10e-6;
        w67 = 150e-6;
        Wij = [w23; w34; w44; 
            w44; w44; w44;
            w34; w56; w67];
        
        % Channel connectivity (channel connects start node to end node)
        C = zeros(length(Lij), 2);
        C(:, 1) = [1, 2, 3, 3, 8, 9, 4, 5, 6]; % Start node
        C(:, 2) = [2, 3, 4, 8, 9, 4, 5, 6, 7]; % End node
        
        % Store this info as a directed graph
        G = digraph(C(:, 1), C(:, 2), Lij * 1e3);
        G.Edges.Length(findedge(G,C(:, 1), C(:, 2))) = Lij;
        G.Edges.Width(findedge(G,C(:, 1), C(:, 2))) = Wij;
        G.Edges.Height(findedge(G,C(:, 1), C(:, 2))) = Hij;
        
    case 'parallel_2'
        disp('ID: Parallel_2')
        % Channel lengths (m)
        L23 = 500e-6;
        L34 = 70e-6;
        L44 = 180e-6;
        L56 = L23;
        L67 = 21e-3;
        Lij = [L23; L34; L44; 
            L44/3; L44/3; L44/3; % Add two copies of the L44 segment in
            L44/3; L44/3; L44/3; % parallel, divided where they bend
            L34; L56; L67];
        
        % Channel heights (m)
        h23 = 100e-9;
        h34 = 100e-9;
        h44 = 100e-9;
        h56 = 100e-9;
        h67 = 60e-6;
        Hij = [h23; h34; h44; 
            h44; h44; h44;
            h44; h44; h44; 
            h34; h56; h67];
        
        % Channel widths (m)
        w23 = 10e-6;
        w34 = 10e-6;
        w44 = 120e-6;
        w56 = 10e-6;
        w67 = 150e-6;
        Wij = [w23; w34; w44; 
            w44; w44; w44;
            w44; w44; w44; 
            w34; w56; w67];
        
        % Channel connectivity (channel connects start node to end node)
        C = zeros(length(Lij), 2);
        C(:, 1) = [1, 2, 3, 3, 8, 9, 8, 10, 11, 4, 5, 6]; % Start node
        C(:, 2) = [2, 3, 4, 8, 9, 4, 10, 11, 9, 5, 6, 7]; % End node
        
        % Store this info as a directed graph
        G = digraph(C(:, 1), C(:, 2), Lij * 1e3);
        G.Edges.Length(findedge(G,C(:, 1), C(:, 2))) = Lij;
        G.Edges.Width(findedge(G,C(:, 1), C(:, 2))) = Wij;
        G.Edges.Height(findedge(G,C(:, 1), C(:, 2))) = Hij;
        
    case 'parallel_3'
        disp('ID: Parallel_3')
        % Channel lengths (m)
        L23 = 500e-6;
        L34 = 70e-6;
        L44 = 180e-6;
        L56 = L23;
        L67 = 21e-3;
        Lij = [L23; L34;
            L44/3; L44/3; L44/3;
            L44/3; L44/3; L44/3;
            L34; L56; L67];
        
        % Channel heights (m)
        h23 = 100e-9;
        h34 = 100e-9;
        h44 = 100e-9;
        h56 = 100e-9;
        h67 = 60e-6;
        Hij = [h23; h34;
            h44; h44; h44;
            h44; h44; h44; 
            h34; h56; h67];
        
        % Channel widths (m)
        w23 = 10e-6;
        w34 = 10e-6;
        w44 = 120e-6;
        w56 = 10e-6;
        w67 = 150e-6;
        Wij = [w23; w34;
            w44; w44; w44;
            w44; w44; w44; 
            w34; w56; w67];
        
        % Channel connectivity (channel connects start node to end node)
        C = zeros(length(Lij), 2);
        C(:, 1) = [1, 2, 3, 8, 9, 3, 10, 11, 4, 5, 6]; % Start node
        C(:, 2) = [2, 3, 8, 9, 4, 10, 11, 4, 5, 6, 7]; % End node
        
        % Store this info as a directed graph
        G = digraph(C(:, 1), C(:, 2), Lij * 1e3);
        G.Edges.Length(findedge(G,C(:, 1), C(:, 2))) = Lij;
        G.Edges.Width(findedge(G,C(:, 1), C(:, 2))) = Wij;
        G.Edges.Height(findedge(G,C(:, 1), C(:, 2))) = Hij;
        
%     case <add new geometry case expression here>
    otherwise
        error(['Unknown geometry. Currently configured options are: '...
            'wellmixed, pfrlike, parallel. To add a new geometry, '...
            'please edit setGeometry.m'])
end

% Check graph is suitable
if ismultigraph(G)
    error(['Network of channels form a multigraph. Make sure each pair '...
        'of junctions is only connected by a single channel.'])
end
if ~isdag(G)
    error(['Network of channels is not directed and acyclic. Check '...
        'connections. There should not be any loops.'])
end

% Check graph has an inlet node and an outlet node
inletnode = 0;
outletnode = 0;
for i = 1:numedges(G)
    if isempty(find(G.Edges.EndNodes(i, 1) == G.Edges.EndNodes(:, 2), 1))
        inletnode = G.Edges.EndNodes(i, 1);
    end
    if isempty(find(G.Edges.EndNodes(i, 2) == G.Edges.EndNodes(:, 1), 1))
        outletnode = G.Edges.EndNodes(i, 2);
    end
end
if inletnode == outletnode
    error('Channel connectivity issue. In and out nodes are the same.')
end
if inletnode == 0
    error('No inlet point found. Check connectivity.')
end
if outletnode == 0
    error('No outlet point found. Check connectivity.')
end

% Flag endpoints
connectsInlet = zeros(numedges(G), 1);
connectsOutlet = zeros(numedges(G), 1);
connectsInlet(G.Edges.EndNodes(:, 1) == inletnode) = 1;
connectsOutlet(G.Edges.EndNodes(:, 2) == outletnode) = 1;
G.Edges.ConnectsIn = connectsInlet;
G.Edges.ConnectsOut = connectsOutlet;

% Classify the nodes and edges
events = {'edgetonew', 'edgetodiscovered', 'edgetofinished', 'startnode'};
tab = dfsearch(G, inletnode, events, 'Restart', true);

disp('Edge endpoints (junctions) and weights (lengths):')
disp(G.Edges)
% disp('Results of depth first search from node 1:')
% disp(tab)

figure(1)
set(gcf, 'color', 'white')
p = plot(G, 'EdgeLabel', G.Edges.Weight,...
    'edgecolor', 'k', 'nodecolor', 'k', 'layout', 'force');
highlight(p, 'Edges', tab.EdgeIndex(tab.Event == 'edgetonew'),...
    'EdgeColor', 'b')
highlight(p, 'Edges', tab.EdgeIndex(tab.Event == 'edgetofinished'),...
    'EdgeColor', 'k')
highlight(p, 'Edges', tab.EdgeIndex(tab.Event == 'edgetodiscovered'),...
    'EdgeColor', 'm')
highlight(p, tab.Node(~isnan(tab.Node)), 'NodeColor', 'r')
title('System connectivity')
set(gca,'XTick', [], 'YTick', [])
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 6.6 6.6])
saveas(gcf, ['figs/systemConnectivity_' geom_type '.png'])

end