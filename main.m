% Добавление папки с классами в путь MATLAB
addpath('../src');
addpath('.');

clc; clear variables; close all;

% Параметры системы
params = struct( ...
    'b0', 1, 'b1', -1, 'b2', 0, ...
    'a0', 1, 'a1', 3, 'a2', 3, 'a3', 4);

numeratorCoeffs = [params.b2 params.b1 params.b0];
denominatorCoeffs = [params.a3 params.a2 params.a1 params.a0];
systemTransferFunction = tf(numeratorCoeffs, denominatorCoeffs);

% Анализ устойчивости
coefficients = [params.a3 params.a2 params.a1 params.a0];
analyzer = StabilityAnalyzer(coefficients);
analyzer.analyzeStability();


% Анализ частотных характеристик
bode_analysis;

% Анализ переходной функции
step_response;

% Анализ импульсной функции
impulse_response;

% Анализ корневого годографа
pzmap_analysis;

% Анализ отклика на произвольный входной сигнал
custom_input_response;

% Анализ маргиналов устойчивости
margin_analysis;