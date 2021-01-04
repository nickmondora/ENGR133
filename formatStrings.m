function [strings,substring] = formatStrings(strings)

% Program Description 
%Formats a string for later use with IntegralCalculator or
%DerivativeCalculator.  First, converts string to lowercase.  Then
%determines if the stings contains 'int' or 'der', and removes either.
%Also removes characters ( ) ' and any extra spaces.  It adds * before
%variable 'x' whenever appropriate.  Lastly, it replaces '' or " with ^ and
%— with -.
%
% Function Call
%formatStrings(strings)
%
% Input Arguments
%strings is a string type variable that contains a function.
%
% Output Arguments
%Returns a string variable, 'strings', that contians the formatted string.
%Also reutrns variable 'substring' which contains either 'der' or 'int'.
%This indicates whether the string called for integral or derivative.

%% Initial Formatting
%Converts string to lowercase
strings = lower(strings);
%Joins the multiple string values into one
strings = join(strings);
%Deletes 'der' from the string
if contains(strings, 'der')
    strings = strrep(strings,'der','');
    substring = 'der';

%Deletes 'int' from the strind
elseif contains(strings, 'int')
    strings = strrep(strings,'int','');
    substring = 'int';
else
    error('Could not determine the proper function to be evaluated (integral or derivative).  Ensure that text begins with "int" or "der"');
end
%Deletes ( and ) from the string
strings = strrep(strings,'(','');
strings = strrep(strings,')','');
%Removes any extra spaces from the string
strings = strip(strings);
%Converts strings to matrix.  This helps us with indexing of individual
%characters
strings = cell2mat(strings);

%% Additive Formatting
%Adds a multiplication sign before any 'x'.  This helps MatLab recognize
%that the coefficient is being multiplied by x
indices = strfind(strings, 'x')
% indices = cell2mat(indices)
%j counts how many * have been added to the string.
j = 0

if length(indices) > 0
for i = 1:length(indices)
    i
    if indices(i) ~= 1
        pos = indices(i) - 1 + j
        if all(ismember(strings(pos), '0123456789+-.eEdD')) == 1
        strings = insertBefore(strings,indices(i)+j,'*')
        j = j + 1
        end
    end
end
end


%% Replace Formatting
%Replaces quotation marks with carats for exponents.  OCR recognizes carats
%as quotation marks.  Then replaces em dash with hypen
strings = strrep(strings,'"','^')
strings = strrep(strings,'“','^')
strings = strrep(strings,'—','-')