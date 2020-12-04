function plotAndWritePressures(P, T, G, geom_type)

options = optimoptions('fsolve', 'Display', 'off', 'TolFun',...
    1e-8, 'TolX', 1e-8);

nChannels = numedges(G);

% Make some points along the channel to solve for pressure profile
x_ij = zeros(nChannels, 100);
for channel = 1:nChannels
    x_ij(channel, :) = linspace(0, G.Edges.Length(channel));
end

% Remove any negligible imaginary components of the solved pressures
if imag(P) > 1e-10
    disp('Pressure has non-negligible imaginary component!')
else
    P = real(P);
end

% Check for negative pressures
if P < 0
    disp('Negative pressures found!')
end

% Pressure loss across channel connecting nodes ni and nj
myP1 = zeros(nChannels, 100);
for channel = 1:nChannels
    ni = G.Edges.EndNodes(channel, 1);
    nj = G.Edges.EndNodes(channel, 2);
    Pi = P(ni);
    Pj = P(nj);
    Lij = G.Edges.Length(channel);
    Hij = G.Edges.Height(channel);
    for i = 1:100
        x = x_ij(channel, i);
        Prat = 1;
        if (i > 1)
            Prat = myP1(channel, i - 1) / Pi;
        end
        fanon = @(P) (P_tilde(P, x, Pi, Pj, Hij, Lij, T));
        myP1(channel, i) = Pj * fsolve(fanon, Prat, options);
        if imag(myP1(channel, i)) > 1e-10
            disp('Pressure has non-negligible imaginary component!')
        else
            myP1(channel, i) = real(myP1(channel, i));
        end
        if myP1(channel, i) < 0
            disp('Negative pressures found!')
        end
    end
end

% Compute the paths through the channel network from the first to last node
inletnode = G.Edges.EndNodes(find(G.Edges.ConnectsIn == 1, 1), 1);
outletnode = G.Edges.EndNodes(find(G.Edges.ConnectsOut == 1, 1), 2);
paths = pathbetweennodes(adjacency(G), inletnode, outletnode);
disp(['Finding paths between start node ' num2str(inletnode)...
    ' and end node ' num2str(outletnode) ':'])
for i = 1:length(paths)
    str = '';
    for j = 1:length(paths{i})
        str = strcat(str, num2str(paths{i}(j)));
        if j < length(paths{i})
            str = strcat(str, '-');
        end
    end
    disp(str)
    pathnames{i} = str;
end

% String together the lengths and pressures for connected channels
for i = 1:length(paths)
    seg{i} = zeros(length(paths{i}) - 1, 1);
    for j = 1:length(paths{i}) - 1
        i1 = G.Edges.EndNodes(:, 1) == paths{i}(j);
        i2 = G.Edges.EndNodes(:, 2) == paths{i}(j+1);
        seg{i}(j) = find(i1 .* i2 == 1, 1);
        if j == 1
            xpath{i} = x_ij(seg{i}(j), :);
            Plpath{i} = myP1(seg{i}(j), :);
        else
            xpath{i} = [xpath{i}, xpath{i}(end) + x_ij(seg{i}(j), :)];
            Plpath{i} = [Plpath{i}, myP1(seg{i}(j), :)];
        end
    end
end

for i = 1:length(paths)
    figure(i + 1)
    set(gcf, 'color', 'white')
    indsig = find(Plpath{i} >= 1e-1);
    semilogy(1e6 * xpath{i}(indsig), Plpath{i}(indsig) * 1e-5, 'k')
    hold on
    indsig = find(P(paths{i}) >= 1e-1);
    xvals = 1e6 * [0; cumsum(G.Edges.Length(seg{i}))];
    semilogy(xvals(indsig), P(paths{i}(indsig)) * 1e-5, 'or')
    xlabel('Position [\mum]')
    ylabel('Pressure [bar]')
    title(['System pressure profile, path ' pathnames{i}])
    set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 6.6 6.6])
    saveas(gcf, ['figs/systemPressureProfile_' geom_type '_path_',...
        pathnames{i} '.png'])
end

if length(paths) > 1
    figure(length(paths) + 2)
    set(gcf, 'color', 'white')
    for i = 1:length(paths)
        indsig = find(Plpath{i} >= 1e-1);
        semilogy(1e6 * xpath{i}(indsig), Plpath{i}(indsig) * 1e-5)
        hold on
        indsig = find(P(paths{i}) >= 1e-1);
        xvals = 1e6 * [0; cumsum(G.Edges.Length(seg{i}))];
        semilogy(xvals(indsig), P(paths{i}(indsig)) * 1e-5, 'or')
    end
    h = gca;
    l = legend(h.Children(end:-2:1), pathnames, 'Location', 'South');
    l.Box = 'Off';
    xlabel('Position [\mum]')
    ylabel('Pressure [bar]')
    title('System pressure profile, all paths')
    set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 6.6 6.6])
    saveas(gcf, ['figs/systemPressureProfile_' geom_type '.png'])
end

% % WRITE PRESSURE DATA TO FILE
% % -----------------------------------------------------
for i = 1:length(paths)
    fp = fopen(['data/figure1_data_' geom_type '_path_' pathnames{i},...
        '.txt'], 'w');
    fprintf(fp, 'Position [m] Pressure [Pa]\n');
    for j=1:length(Plpath{i})
        fprintf(fp, '%e %e\n', xpath{i}(j), Plpath{i}(j));
    end
    fclose(fp);
end
% % -----------------------------------------------------

end