% AC50002 PROGRAMMING LANGUAGES FOR DATA ENGINEERING
% 
% MATLAB ASSIGNMENT
% 
% Lecturer:	Emanuele (Manuel) Trucco
% Lab tutors:	Roberto Annunziata, Andrew McNeil
% 
clear all, close all


% Problem description
% 1.	
% Generate 200 real numbers from a Gaussian distribution, with mean 0 and standard deviation 1. 
sample_size=200;
y_gauss_mn0_sd1=randn(sample_size,1);

    
% Generate a histogram of the sample, choosing the number of bins with the Freedman-Diaconis rule.
%[nb_bins,edges,bin_vector]=histcounts(y_gauss_mn0_sd1,'BinMethod','fd')
figure
histogram(y_gauss_mn0_sd1,'BinMethod','fd') 

std_dev=std(y_gauss_mn0_sd1)
figure
subplot(3,4,1)
histfit(y_gauss_mn0_sd1) 
title( 'Before any replacements')        
xlabel(strcat('standard deviation =', num2str(std_dev)))
axis([-7 7 0 60])

% 2.
% Run a Chi-square test for Gaussianity to test the hypothesis that the numbers are a sample 
% sample from a Gaussian distribution. 
% Report the result in terms of answer (yes or no) and significance level.
variance=var(y_gauss_mn0_sd1)
fprintf ('significance level \t| test rejects H0 that data follows a normal distribution \n')
for significance_level = 0.01:0.01:0.05
    %response = vartest(y_gauss_mn0_sd1, variance, 'Alpha', significance_level);
    response = chi2gof(y_gauss_mn0_sd1, 'Alpha', significance_level);
% Alpha : significance level is .05 by default
% H0 : data x comes from a normal distribution with a given variance
% vartest returns 
%   1 : H0 is rejected at given significance level
%   0 : 
    if response(1)==0
        response_text='No.  Failed to reject H0';
    else
        response_text='Yes. Rejects H0';
    end
fprintf ('\t\t%.2f \t\t\t%s \n', significance_level, response_text)
end

% 3.	Eliminate 10 numbers, chosen at random, from the initial set, 
% and replace them with numbers drawn from a uniform distribution of mean 0 and standard deviation 3.
nb_updated_values=10;
uniform_std_dev=3;
y_mn0 = y_gauss_mn0_sd1;
% standard deviation sd for a uniform distribution of mean 0 and x on range [-x_max:x_max]
% sd = ( b - a ) / sqrt(12) = x_max / sqrt (3) => x_max = sd * sqrt (3) 
x_max = uniform_std_dev * sqrt (3)

nb_loops=10;
for loop_i = 1:nb_loops
    fprintf ('Loop #%d \n', loop_i);    
    random_value=rand(nb_updated_values,1) * 2 * x_max - x_max ;
    std(random_value)
    random_index=round(rand(nb_updated_values,1)*sample_size) + 1;
    for i = 1:nb_updated_values
        y_mn0 ( random_index(i) ) = random_value (i) ;
    end
% 4.	Repeat step 2.
    variance=var(y_mn0)
    std_dev=std(y_mn0)
    fprintf ('significance level \t| test rejects H0 that data follows a normal distribution \n')
    for significance_level = 0.01:0.01:0.05
        response = chi2gof(y_mn0, 'Alpha', significance_level);
        if response(1)==0
            response_text='No.  Failed to reject H0';
        else
            response_text='Yes. Rejects H0';
        end
    fprintf ('\t\t%.2f \t\t\t%s \n', significance_level, response_text)
    end
    
    subplot(3,4,loop_i+1)
    %histogram(y_mn0)
    histfit(y_mn0)
    title( strcat('After' , {' '}, num2str(loop_i * nb_updated_values ), ' replacements'))
    xlabel(strcat('standard deviation =', num2str(std_dev)))
    axis([-7 7 0 60])

% 5.	Repeat steps 3 and 4 for 10 times, each time removing 10 numbers in random positions from the original Gaussian sample, and replacing them with a new set of uniform deviates.
end;




