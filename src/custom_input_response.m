% Отклик на произвольный входной сигнал
t = 0:0.01:10;
u = sin(2*pi*t) + cos(2*pi*0.5*t);  % Пример произвольного сигнала
figure;
lsim(systemTransferFunction, u, t);
title('Отклик на произвольный входной сигнал');
grid on;