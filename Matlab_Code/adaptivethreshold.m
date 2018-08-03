function bw  = adaptivethreshold(image)
 
[rows, cols, dim] = size(image);
if(dim > 2) 
    im1 = rgb2gray(image); 
else 
    im1 = im;
end

im2 = imfilter(im1, fspecial('average',7), 'replicate'); 

%Edge Detection 
sim = im2- im1- 10;

bw = im2bw(sim, 0);
end

