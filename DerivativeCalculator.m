function [indef,def,fun,answer] = DerivativeCalculator(strings)

% Program Description 
%Calculates and returns the indefinite derivative and definite derivative
%at one point specified by the user.
%
% Function Call
%DerivativeCalculator(strings)
%
% Input Arguments
%strings is a string type variable that contains a function.  It is
%reccomended to use formatStrings(strings) prior to
%DerivativeCalculator(strings).
%
% Output Arguments
%Returns the indefinite derivative as variable 'indef', definite derivative at one point (a) as variable 'def', the point a 'answer', and the
%original function as variable 'fun'
%


%% Differentiation
%Asks the user for bounds of integration
prompt = {'Enter x-value to evaluate derivative at:'};
dlgtitle = 'Input';
dims = [1 40];
definput = {'a'};
answer = inputdlg(prompt,dlgtitle,dims,definput);
%Converts answer to double
ans_dou = cell2mat(answer(1));
ans_dou = str2double(ans_dou);

%Converts string to symbolic variable
strings = str2sym(strings);
%Calculates indefinite and definite integrals
syms x;
indef = diff(strings);
def = subs(indef,x,ans_dou);
fun = strings;


%% Plots
figure(5);
hold on;
grid on;
%Plots the origional function
fplot(fun);
%Plots the indefinite integral
fplot(indef);

%Plots a dot at the point at which the derivative is calculated
x_dot = ans_dou;
y_dot = double(def);
plot(x_dot,y_dot,'.', 'MarkerSize', 30);

%Creates a legend for the plot
answer2(1) = cell2sym(answer(1));
text3 = sprintf('Derivative at x= %s: %s',answer2(1),def);
text1 = sprintf('Original function: y = %s',fun);
text2 = sprintf('Derivative: y = %s',indef);
legend(text1,text2,'Location','Best');
%Titles the plot with the value of the definite integral
title(text3);
