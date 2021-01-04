function ocrResults = performOCR(roi)
% Program Description 
%Performs optical character recognition on an image, given a certain region
%of interest
%
% Function Call
%performOCR(roi)
%
% Input Arguments
%roi is the region of interest.  Specify roi as a four-element vector of
%the form [x y w h] in data units. The x and y elements determine the
%location and the w and h elements determine the size.
%
% Output Arguments
%Returns one variable ocrResults.  This is a ocrText type variable.  It
%contains: text, character bounding boxes, character confidences, words,
%word bounding boxes, and word confidences.
%


%% Image Recognition
%Read picture
picture = imread('Image4Processing.png');
%Perform OCR.  Looks for a line of text in the region of interest
ocrResults = ocr(picture, roi,'TextLayout','Line');
%Displays the image with word confidences overlayed
figure(2);
Iocr = insertObjectAnnotation(picture, 'rectangle', ocrResults.WordBoundingBoxes, ocrResults.WordConfidences);
figure; imshow(Iocr);
%Waits 2 seconds then closes the figure
pause(2);
close all;
%Shows the image with the interpreted string overlayed
figure(4);
Iocr2 = insertText(picture,roi(3:4),ocrResults.Text,'AnchorPoint','LeftTop','FontSize',16);
figure; imshow(Iocr2);
