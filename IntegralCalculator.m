function [indef,def,fun,answer] = IntegralCalculator(strings)

% Program Description 
%Calculates and returns the indefinite integral and definite integral
%between 2 points (a and b) specified by the user.
%
% Function Call
%IntegralCalculator(strings)
%
% Input Arguments
%strings is a string type variable that contains a function.  It is
%reccomended to use formatStrings(strings) prior to
%IntegralCalculator(strings).
%
% Output Arguments
%Returns the indefinite integral as variable 'indef', definite integral between two points (a
%and b) as variable 'def', the points a and b as variable 'answer', and the
%original function as variable 'fun'
%



%% Integration
%Asks the user for bounds of integration
prompt = {'Enter lower bound of integration:','Enter upper bound of integration:'};
dlgtitle = 'Input';
dims = [1 40];
definput = {'a','b'};
answer = inputdlg(prompt,dlgtitle,dims,definput);


%Converts string to symbolic variable
%strings = mat2str(strings)   %First coverts it to a string
strings = str2sym(strings);   %Then converts it to a symbolic equation

%Calculates indefinite and definite integrals
syms x;
indef = int(strings);   %Caluclates the indefinite integral
def = int(strings,answer(1),answer(2));    %Calculates the definite integral
fun = strings;    %Sets fun equal to the function in variabel 'equations'


%% Plots
figure(5);
hold on;
grid on;
%Plots the origional function
fplot(fun);
%Plots the indefinite integral
fplot(indef);




%Plots horizontal line at a y=0
yline(0,'--k','LineWidth',1);


%Convert symbolic expression to function handle
y = matlabFunction(fun);
x = linspace(str2num(cell2mat(answer(1))),str2num(cell2mat(answer(2))));
inty = y(x);
hold on;
%Colors the area below the function
patch([x fliplr(x)], [zeros(size(x)) fliplr(inty)], 'g');
grid on;



%Creates a legend for the plot
answer2(1) = cell2sym(answer(1));
answer2(2) = cell2sym(answer(2));
text3 = sprintf('Integral from %s to %s = %s',answer2(1),answer2(2),def);
text1 = sprintf('Original function: y = %s',fun);
text2 = sprintf('Integral: y = %s',indef);
legend(text1,text2,'Location','Best');
%Titles the plot with the value of the definite integral
title(text3);




