function plotAndWritePressures(P, T, L_W_H, geom_type)

options = optimoptions('fsolve', 'Display', 'off');

x_ij = zeros(length(L_W_H) - 1, 100);
x_total = zeros((length(L_W_H) - 1) * 100, 1);
for i = 1:length(L_W_H) - 1
    x = linspace(0, L_W_H(i, 1));
    x_ij(i, :) = x;
    if i == 1
        x_total(1:100) = x;
    else
        x_total((i - 1) * 100 + 1: i * 100) = x + sum(L_W_H(1:i - 1, 1));
    end
end

myP1 = zeros(1, length(x_total));

% Segment i - j
for segment = 1:length(L_W_H) - 1
    Pi = P(segment);
    Pj = P(segment + 1);
    Hij = L_W_H(segment, 3);
    Lij = L_W_H(segment, 1);
    for i=1:100
        x = x_ij(segment, i);
        Prat = 1;
        if (i > 1)
            Prat = myP1((segment - 1) * 100 + i - 1) / Pi;
        end
        fanon = @(P) (P_tilde(P, x, Pi, Pj, Hij, Lij, T));
        myP1((segment - 1) * 100 + i) = Pj * fsolve(fanon, Prat, options);
    end
end

figure(1)
set(gcf, 'color', 'white')
semilogy(1e6 * x_total, myP1 * 1e-5, '-k')
hold on
semilogy(1e6 * [0; cumsum(L_W_H(:, 1))], P * 1e-5, 'or')
ypnts = [P(end - 1) P(1)];
semilogy(1e6 * [0 0], ypnts * 1e-5, ':k')
for i = 1:length(L_W_H) - 1
    xpnts = [sum(L_W_H(1:i, 1)) sum(L_W_H(1:i, 1))];
    semilogy(1e6 * xpnts, ypnts * 1e-5, ':k')
end
axis([0 (1e6 * x_total(end)) (1e-1 * 1e-5) (1e6 * 1e-5)])
xlabel('Position [\mum]')
ylabel('Pressure [bar]')
set(gca, 'XTick', [0 250 500 750 1000 1250])
title('System pressure profiles')
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 3.3 3.3])
saveas(gcf, ['figs/systemPressureProfile_' geom_type '.png'])

% UNCOMMENT THIS SECTION TO WRITE PRESSURE DATA TO FILE
% -----------------------------------------------------
fp = fopen(['data/figure1_data_' geom_type '.txt'], 'w');
fprintf(fp, 'Position [m] Pressure [Pa]\n');
for i=1:length(myP1)
    fprintf(fp, '%e %e\n', x_total(i), myP1(i));
end
fclose(fp);
% -----------------------------------------------------

figure(2)
set(gcf, 'color', 'white')
plot(1e6 * x_total, myP1 * 1e-5, '-k')
hold on
xpnts = [sum(L_W_H(1:2, 1)) sum(L_W_H(1:2, 1))];
semilogy(1e6 * xpnts, ypnts * 1e-5, ':k')
xpnts = [sum(L_W_H(1:3, 1)) sum(L_W_H(1:3, 1))];
semilogy(1e6 * xpnts, ypnts * 1e-5, ':k')
xlabel('Position [\mum]')
ylabel('Pressure [bar]')
axis([(L_W_H(1, 1) * 1e6) (sum(L_W_H(1:4, 1)) * 1e6)...
     (P(end - 2) * 1e-5) (P(2) * 1e-5)])
title('Nanochannels pressure profiles')
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 3.3 3.3])
saveas(gcf, ['figs/nanochannelPressureProfile_' geom_type '.png'])

end