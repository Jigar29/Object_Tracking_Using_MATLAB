clear; 
clc; 
close all; 
clear all; 

% Creating The Video Object
v = VideoReader('Desktop111.wmv');

for i=1:25
%Starting the timer 
tic;      

%Reading the image fram to process the object detection 
snap = read(v, i); 
subplot(2,1,1);
imshow(snap); 
title('Original Image'); 

%object Detection algorithm 
[out, start_add, end_addr] = object_detect(snap);

%Marker location calculation 
marker = [(start_add(1,2)+end_addr(1,2)/2), start_add(1,1) + end_addr(1,1)/2];
 
a = insertMarker(snap,round(marker));

subplot(2,1,2);
imshow(a);
title('Processed Image'); 

%creating the bounding box around the object 
rectangle('Position', [start_add(1,2),start_add(1,1), end_addr(1,2),end_addr(1,1)],'EdgeColor','r','LineWidth',2 );
fprintf('Time for one frame processing is %f Seconds\n', toc); 

close all;
end
