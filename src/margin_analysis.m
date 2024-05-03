% Маргиналы устойчивости
figure;
[Gm, Pm, Wcg, Wcp] = margin(systemTransferFunction);
margin(systemTransferFunction);
title('Маргиналы устойчивости');
grid on;

% Вывод значений маргиналов устойчивости
disp(['Гейн маржин: ', num2str(Gm), ' dB при ', num2str(Wcg), ' рад/с']);
disp(['Фазовый маржин: ', num2str(Pm), ' градусов при ', num2str(Wcp), ' рад/с']);