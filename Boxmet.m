clc
clear all
close all
% Read the input image
img = imread('C:\Users\njsiw\Desktop\dataset\Original\bb0.jpg');

M2d = im2double(img);

figure(1), imshow(M2d);

% Extract red and blue channels
[R,G,B] = imsplit(M2d);

% Create a binary image based on the red and blue channels
[m2, n2] = size(R);
        X = zeros(m2,n2);
         for i = 1:m2
          for k = 1:n2
           if R(i,k) >= 0 && R(i,k) <= 0.20 && G(i,k) <= 0.40  && B(i,k) >= 0.43
            X(i,k) = 255;
           end
          end
         end

         X = medfilt2(X, [3 3]);
         figure(2),imshow(X)

% Convert binary image to grayscale and display
Mfor = mat2gray(X);
figure(3),imshow(Mfor)


% Remove small objects
Mao = bwareaopen(Mfor,1500);
figure(4),imshow(Mao)

SE = strel('disk',20);
Mc = imclose(Mao,SE);
figure(5),imshow(Mc)

% Extract properties of connected components
cc = regionprops(Mc, 'Centroid', 'BoundingBox');

% Draw bounding box on original image
figure(6), imshow(img);
hold on;
for i = 1:length(cc)
    bb = cc(i).BoundingBox;
    rectangle('Position', bb, 'EdgeColor', 'r', 'LineWidth', 2);
end
hold off;


