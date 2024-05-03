% tests.m - Скрипт для запуска тестов

% Добавление папки с классами в путь MATLAB
addpath('../src');
addpath('.');

clc; clear variables; close all;

% Запуск тестов для StabilityAnalyzer
results = runtests('StabilityAnalyzerTest');
disp(results);
