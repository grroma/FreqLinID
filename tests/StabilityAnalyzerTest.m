%{
    Тесты для класса 'StabilityAnalyzer'
%}
classdef StabilityAnalyzerTest < matlab.unittest.TestCase
    methods (Test)
        % Тестирование устойчивой системы с корнями в левой полуплоскости
        function testStableSystem(testCase)
            disp('Start: testStableSystem');
            % Все корни с отрицательными реальными частями
            coeffs = [1, 6, 11, 6];
            analyzer = StabilityAnalyzer(coeffs);
            isStable = analyzer.analyzeStability(true);
            testCase.verifyTrue(isStable, ...
                'Проверка устойчивости неудачна: Система должна быть устойчива.');
        end
        
        % Тестирование неустойчивой системы с корнями в правой полуплоскости
        function testUnstableSystem(testCase)
            disp('Start: testUnstableSystem');
            % Все корни с положительными реальными частями
            coeffs = [1, -3, 3, -1];
            analyzer = StabilityAnalyzer(coeffs);
            isStable = analyzer.analyzeStability(true);
            testCase.verifyFalse(isStable, ...
                'Проверка устойчивости неудачна: Система должна быть неустойчива.');
        end
        
        function testMarginallyStableSystem(testCase)
            disp('Start: testMarginallyStableSystem');
            % Корни на мнимой оси (s^2 + 1 = 0)
            coeffs = [1, 0, 1];
            analyzer = StabilityAnalyzer(coeffs);
            [isStable, message] = analyzer.analyzeStability(true);
            
            % Проверяем, что система не классифицируется как абсолютно устойчива
            testCase.verifyFalse(isStable, ...
                'Проверка устойчивости неудачна: Система не должна быть классифицирована как абсолютно устойчива.');
            
            % Проверяем, что выводится правильное сообщение о маргинальной устойчивости
            expectedMessage = 'Система может быть маргинально устойчива. Необходим дополнительный анализ.';
            testCase.verifyEqual(message, expectedMessage, ...
                'Сообщение о маргинальной устойчивости не соответствует ожидаемому.');
        end
        
        % Тестирование неустойчивой системы с положительными корнями
        function testUnstableSystemWithPositiveRoots(testCase)
            disp('Start: testUnstableSystemWithPositiveRoots');
            % Система с положительными корнями
            coeffs = [1, -2, -1, 2];
            analyzer = StabilityAnalyzer(coeffs);
            isStable = analyzer.analyzeStability(true);
            testCase.verifyFalse(isStable, ...
                'Проверка устойчивости неудачна: Система должна быть неустойчива, так как есть корни с положительными реальными частями.');
        end
        
        % Тестирование неустойчивой системы с нулевыми корнями
        function testUnstableSystemWithZeroRoots(testCase)
            disp('Start: testUnstableSystemWithZeroRoots');
            % Система с корнем в нуле
            coeffs = [1, 0, 0, 0];
            analyzer = StabilityAnalyzer(coeffs);
            isStable = analyzer.analyzeStability(true);
            testCase.verifyFalse(isStable, ...
                'Проверка устойчивости неудачна: Система должна быть неустойчива, так как имеется корень в нуле.');
        end
    end
end
