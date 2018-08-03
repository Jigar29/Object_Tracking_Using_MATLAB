%Fnction to detect the single object in the image 
%Input Arguments : Image Matrix 
%Output          : Object Array, Start_location, End Location

function [output, start, end_a] = object_detect(data_input)
    
    %Adaptive Thresholding Function
    snap_z1 = adaptivethreshold(data_input); 
    %Filling the detected image 
    snap_z = imfill(snap_z1, 'holes'); 
    [rows, cols] = size(snap_z); 
    
    %Checking Connected pixels 
    for i=2:rows-1
        for j=2:cols-1 
            if((snap_z(i+1,j) || snap_z(i-1,j) || snap_z(i,j-1) || snap_z(i,j+1)) == 1);
                data(i,j) = 1;
            end
        end
    end
    [rows, cols] = size(data); 

    %Array Adjustment 
    j1 =0; 
    a = data; 
    for j=1:cols
        if(data(:,j) == 0) 
            a(:,j-j1) = []; 
            j1= j1+1; 
        end
    end
    i1 =0; 
    d = a ;
    for i=1:rows
        if(d(i,:) == 0) 
            a(i-i1,:) = []; 
            i1= i1+1; 
        end
    end
    
    %padding zeros srounding the detected object array
    d = padarray(a,[5 5]);
    
    %Applying high pass Filter to restore the original image 
    filter = [1, 1, 1; 1 -8 1; 1 1 1]; 
    output = imfilter(d, filter);
    %Marker Location Caluclation 
    [rows_d, cols_d] = size(data);
    [rows_a, cols_a] = size(a);
    start = [rows_d- rows_a, cols_d - cols_a]; 
    end_a = [rows_a, cols_a]; 
end

