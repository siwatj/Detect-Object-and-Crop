clc
clear all
close all

% Read the input image
img = imread('bb50.jpg');

M2d = im2double(img);

figure(1), imshow(M2d);

% Extract red and blue channels
[R,G,B] = imsplit(M2d);

% Create a binary image based on the red and blue channels
[m2, n2] = size(R);
X = zeros(m2,n2);
for i = 1:m2
    for j = 1:n2
        if R(i,j) >= 0 && R(i,j) <= 0.25 && G(i,j) <= 0.45  && B(i,j) >= 0.43
            X(i,j) = 255;
        end
    end
end

% Apply median filtering to remove noise
X = medfilt2(X, [3 3]);
%X = imboxfilt(X, 3);

% Convert binary image to grayscale and display
Mfor = mat2gray(X);
figure(2),imshow(Mfor)

% Remove objects touching the border
%Mcb = imclearborder(Mfor);
%figure(3),imshow(Mcb)

% Remove small objects
Mao = bwareaopen(Mfor,1800);

%figure(4),imshow(Mao);

SE = strel('disk',20);
Mc = imclose(Mao,SE);
figure(4),imshowpair(img, Mc, 'montage');

% Extract properties of connected components
cc = regionprops(Mc, 'Centroid', 'BoundingBox');

% Draw bounding box on original image
%figure(5), imshow(img);
hold on;
for i = 1:length(cc)
    bb = cc(i).BoundingBox;
    rectangle('Position', bb, 'EdgeColor', 'r', 'LineWidth', 2);
end
hold off;
