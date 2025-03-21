function Lab_2_and_3_check_exc(filename)
    % this file checks the excitation contained in filename to help students for the Measurements lab of MA1 EIT. it
    % performs the following checks:
    %   - is there only 1 variable in the mat file?
    %   - is the excitation of appropriate length ?
    %   - is the excitation of appropriate rms ?
    %   - does the excitation have an appropriate max value (crest factor)?
    %
    % last update: 12/03/2024
    arguments 
        filename char
    end
    try 
        load(filename)
        clear filename
    catch ME
        % try to correct the filename with a forgotten extension
        if strcmp(ME.identifier, 'MATLAB:load:couldNotReadFile') && ~endsWith(filename, '.mat')
            filename = strcat(filename, '.mat');
            load(filename)
            clear ME filename
        else
            rethrow(ME)
        end
    end
    all_var = who;

    results_tests = repmat({'Passed'}, 1, 4);
    if length(all_var) > 1
        results_tests{1} = 'Failed';
    end
    x =  eval(all_var{1});
    if length(x) > 2e6 || length(x) < 1e3
        results_tests{2} = 'Failed';
    end
    if rms(x) > 0.55
        results_tests{3} = 'Failed';
    end
    if max(abs(x)) >= 5 
        results_tests{4} = 'Failed';
    end

    fprintf('\n')
    fprintf('\n')
    fprintf('Is there only 1 variable in mat file? ............................................. %s \n', results_tests{1})
    fprintf('Is the length of the signal x between 1000 and 200000 samples? .................... %s \n', results_tests{2})
    fprintf('Is the rms of the signal x appropriate ? .......................................... %s \n', results_tests{3})
    fprintf('Is the maximum value of the signal x appropriate ? ................................ %s \n', results_tests{4})
    fprintf('\n')
    fprintf('\n')

    if any(strcmp(results_tests, 'Failed'))
        error('Excitation Not Ok. Fix it before performing a measurement.')
    else
        fprintf('You can perform a measurement with this excitation. \n \n')
    end
end