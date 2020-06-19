clc, clear, close all

% Plot defaults
set(0,'defaultAxesFontSize',10)
set(0, 'DefaultLineLineWidth', 2);

dataFolder = '../evaluatePressure/data/';

pfrlike = importdata([dataFolder 'figure1_data_wellmixed.txt']);
wellmixed = importdata([dataFolder 'figure1_data_pfrlike.txt']);

x_pfrlike = pfrlike.data(:, 1) * 1e6;
x_wellmixed = wellmixed.data(:, 1) * 1e6;

p_pfrlike = pfrlike.data(:, 2) * 1e-5;
p_wellmixed = wellmixed.data(:, 2) * 1e-5;

figure(1)
set(gcf, 'color', 'white')
plot(x_pfrlike, p_pfrlike, 'color', [0.7 0 0])
hold on
plot(x_wellmixed, p_wellmixed, 'color', [0 0 0.7])
l = legend('PFR-like', 'Well-mixed');
l.Box = 'Off';
set(gca, 'XTick', [0 250 500 750 1000 1250])
title('System pressure profiles')
xlabel('Position [\mum]')
ylabel('Pressure [bar]')
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 3.3 3.3])
saveas(gcf, 'systemPressureProfileComparison.png')

figure(2)
set(gcf, 'color', 'white')
plot(x_pfrlike, p_pfrlike, 'color', [0.7 0 0])
hold on
plot(x_wellmixed, p_wellmixed, 'color', [0 0 0.7])
l = legend('PFR-like', 'Well-mixed');
l.Box = 'Off';
xlabel('Position [\mum]')
ylabel('Pressure [bar]')
set(gca, 'XLim', [500 820])
title('Nanochannels pressure profiles')
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 3.3 3.3])
saveas(gcf, 'nanochannelsPressureProfileComparison.png')
