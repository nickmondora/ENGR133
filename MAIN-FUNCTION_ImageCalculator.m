%%Camera
b = false;  %Initializes b for use in while loop
%This while loop extend through line 56.  It is used to repeat the
%following processes as long as the OCR text generated is not correct.
while b == false
list = webcamlist;   %Gets a list of webcames connected to computer
camchoice = menu('Chose webcam',list);   %Asks the user to select a webcam
cam = webcam(camchoice);    %Connects to the selected webcam


% Create axes control.
handleToAxes = axes();
% Get the handle to the image in the axes.
hImage = image(zeros(720,1280,'uint8'));
% Reset image magnification. Required if you ever displayed an image
% in the axes that was not the same size as your webcam image.
hold off;
axis auto;
axis on;
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% Turn on the live video.
figure(1);
preview(cam, hImage);
hold on;
%Shows a red rectangle in the preview.  The user should adjust the camera
%so that their text is within this box.
roi = [200 240 880 240];   %This ROI is where the rectangle will be.  This
%is the only seciton of the image that we will perform OCR on.
rectangle('Position', [roi(1),roi(2),roi(3),roi(4)], 'EdgeColor','r','LineWidth',2 );

%Pauses for 10 seconds.  This gives the user time to line up their text
%within the roi box.
pause(10);

%Takes picture from webcam and saves as Image4Processing.png
img = snapshot(cam);
imwrite(img,'Image4Processing.png');

%Shows picture taken
close all;  %Closes all figures
figure(2);
imshow(img);  %Shows image that was taken
clear('cam');

%Waits 2 seconds and then closes the image
pause(2)
close all

%Calls UDF to perform optical character recognition
ocrResults = performOCR(roi);
%Asks the user if the image was  good or not
yn = menu('Is the text correct?','Yes','No');
if yn == 1
    b = true;
    %If the text is correct, it breaks the while loop
else
    b = false;
    %If the text is not correct, it repeats the while loop
end
close all;  %Closes all figures
end;


%%Calculating an Integral
%Creates a variabel text with the interpreted words from OCR
text = ocrResults.Words;

%Copies the contents of text to a new variable strings
strings = text;

%Formats strings.  This performs things such as (1) converting to lowercase
%, (2)removing 'int' or 'der', (3) adding * before coefficients, (4)
%removing extra characters such as ( ) or '
[strings,substring] = formatStrings(strings);


%Calls the proper UDF to calculate the integral of derivative
if substring == 'int'
    [indef, def, fun, answer] = IntegralCalculator(strings);  %Calls integral UDF
elseif substring == 'der'
    [indef,def,fun,answer] = DerivativeCalculator(strings);  %Calls derivative UDF
else
    %Prints an error if the string if it does not contain int or der
    error('Could not determine the proper function to be evaluated (integral or derivative).  Ensure that text begins with "int" or "der"');
end


