%% Define functions as tests
function tests = time2FuelCn_Test
tests = functiontests(localfunctions);
end

%% Test function for 10s
function test_case_1_1s(testCase)
actSolution = time2FuelCon('00:00:10:000');
expSolution = 'PT0H0M10.000S';
verifyEqual(testCase,actSolution,expSolution)
end

%% Test function for 1h, 2min, 3s and 4ms
function test_case_1h_2min_3s_2ms(testCase)
actSolution = time2FuelCon('01:02:03:004');
expSolution = 'PT1H2M3.004S';
verifyEqual(testCase,actSolution,expSolution)
end