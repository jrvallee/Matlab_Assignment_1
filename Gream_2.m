%--------------------------------------------------------%
%Clears & closes all 
%--------------------------------------------------------%

clc;
clear;
close all;

%--------------------------------------------------------%
%Generates 200 random numbers with mean = 0 and std = 1
%assigns to y
%--------------------------------------------------------%
meanA = 0;
stdA = 1;
y = stdA.*randn(200,1) + meanA;

for G = 1:10
    fprintf('Attempt: %d\n',G);
    
    %--------------------------------------------------------%
    %Creates a random 10 positions for using to replace values in y
    %--------------------------------------------------------%
    a = 1;
    b = 200;
    r = round((b-a).*rand(10,1) + a);
    %--------------------------------------------------------%
    %Generates 10 random numbers with mean=0 and std = 3
    %assigns to x
    %--------------------------------------------------------%
    stdB = 3;
    x= stdB.*randn(10,1) + meanA;

    %--------------------------------------------------------%
    %Loop to replace values from postion
    %--------------------------------------------------------%
    for K = 1:10
        v = r(K);
        y(v) = x(K);
    end

    %--------------------------------------------------------%
    %Carry out Chi-Square Test
    %--------------------------------------------------------%
    sig = 0.05;
    [h,p,stats] = chi2gof(y,'Alpha',sig);


    if h == 0
        answer = 'yes';
    else
        answer = 'no'; 
    end

    fprintf('The result of the Chi-Square test for gaussianity returns: %s \nwith a significance level of: %3.2f\n',answer,sig)
    %stats
    %figure, histfit(y);
end