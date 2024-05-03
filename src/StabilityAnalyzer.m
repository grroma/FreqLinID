%{
    Класс 'StabilityAnalyzer' предназначен для анализа устойчивости линейных
    систем управления по методу Гурвица-Рауса. Класс позволяет вычислить и анализировать
    таблицу Гурвица-Рауса для данной системы и определить, является ли система устойчивой.

    Автор: @rgrishin

    Пример использования:
        coeffs = [1, 5, 6, 2];  % Коэффициенты полинома знаменателя
        analyzer = StabilityAnalyzer(coeffs);
        isStable = analyzer.analyzeStability();

    Коэффициенты должны быть указаны в порядке убывания степеней s.
    Например, для полинома s^3 + 5s^2 + 6s + 2 коэффициенты будут [1, 5, 6, 2].

    Source: https://gnindia.dronacharya.info/EEE/5thSem/Downloads/ControlSystem/Books/CONTROL-SYSTEM-REFERENCE-BOOK-2.pdf
    6.2 Routh-Hurwitz Criterion, p.302
%}
classdef StabilityAnalyzer
    properties (Access = private)
        Coefficients % Сохраняет коэффициенты полинома знаменателя передаточной функции
    end
    
    methods
        % Конструктор класса, инициализирует объект с коэффициентами знаменателя
        function obj = StabilityAnalyzer(coeffs)
            obj.Coefficients = coeffs; % Присваивает переданные коэффициенты свойству Coefficients
        end
        
        % Публичный метод для анализа устойчивости системы с необязательным параметром verbose
        function [isStable, message] = analyzeStability(obj, verbose)
            if nargin < 2  % Если параметр verbose не передан, устанавливаем его в false
                verbose = false;
            end
            
            [R, isStable, message] = obj.routhTable(verbose);
            
            if verbose
                disp('Таблица Рауса:');
                disp(R);
                disp(message);
            end
            
            if isStable
                disp('Система устойчива по критерию Гурвица-Рауса.');
            else
                disp('Система неустойчива по критерию Гурвица-Рауса.');
            end
            return;
        end
    end
    
    methods (Access = private)
        function [R, isStable, message] = routhTable(obj, verbose)
            a = obj.Coefficients;
            n = length(a);
            R = zeros(n, ceil(n/2));
            R(1, :) = a(1:2:n);
            R(2, :) = a(2:2:n);
            
            for i = 3:n
                for j = 1:(size(R, 2) - 1)
                    if R(i-1, 1) == 0
                        R(i-1, 1) = 1e-6;
                    end
                    R(i, j) = -(R(i-2, 1) * R(i-1, j+1) - R(i-1, 1) * R(i-2, j+1)) / R(i-1, 1);
                end
            end
            
            signChanges = sum(diff(sign(R(:,1))) ~= 0);
            hasImaginaryAxisRoots = any(all(R(1:end-1, :) == 0, 2)) && any(R(end, :) ~= 0);
            isStable = signChanges == 0 && ~hasImaginaryAxisRoots;
            
            if hasImaginaryAxisRoots
                message = 'Система может быть маргинально устойчива. Необходим дополнительный анализ.';
                isStable = false;
            elseif isStable
                message = 'Система устойчива.';
            else
                message = 'Система неустойчива.';
            end
            
            if verbose
                disp('Таблица Рауса:');
                disp(R);
                fprintf('Количество изменений знака в первом столбце: %d\n', signChanges);
                fprintf('Наличие корней на мнимой оси: %s\n', mat2str(hasImaginaryAxisRoots));
                disp(message);
            end
        end
    end
end
