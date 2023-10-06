%% This script is an example of a pratical applications of the matrix inverse. 
% In particular, this is an application in the field of cryptography. So,
% given an image, we will built an involutory matrix and we will use this
% type of matrix to encrypt/ decrypt the image. In fact, given a message M
% and a matrix A, the encrypted messagge will be: Enc_M = A*M.
% To decrypt the message we need the inverse of A: Dec_M = (A-1)AM. We can
% use the involutory matrix because are matrix with the following property:
% A^2 = I --> A*A = I --> The inverse of A is A itself.
close all
clear
clc

% Read the input image
original_img = imread('input-img.jpg');

% Convert into a gray-scale image
original_img_gray = rgb2gray(original_img);

% Convert the int-unsigned matrix of pixel into double-pixel matrix
original_img_gray = im2double(original_img_gray);

% find the size of the img (rows, columns)
[m, n] = size(original_img_gray);

% find the size of the key (size of each block of involutory matrix)
r = m/2;

% Encrypt the input image
[encr_img, k, key]  = encrypt(r, original_img_gray);

% Decrypt the input image
decr_img = decrypt(key, k, r, encr_img);

% Show the results on encryption / decription process
show_incr_decrytp_img(original_img, original_img_gray, encr_img, decr_img);

%% Function to encrypt the image
function [encr_img, k, key] = encrypt (r, img)
[A, k, key] = construct_involutory_matrix (r);
encr_img = A*img;
end

%% Function to decrypt the image
function [decr_img] = decrypt (key, k, r, encr_img)
A = construct_involutory_matrix(r, k, key);
decr_img = A*encr_img;
end

%% Function to plot and compare the encrypeted/ decrypeted matrix
function show_incr_decrytp_img(orig_img, orig_img_gray, encr_img, decr_img)
figure();
subplot(2,2,1);
imshow(orig_img);
title("Original RGB image");

subplot(2,2,2);
imshow(orig_img_gray);
title("Original gray-scale image");

% we need to put the entries bewteen 0 and 255 
% in order to show the img in RGB colors 
subplot(2,2,3);
imagesc(mod(encr_img,255));
title("Encrypted gray-scale image");

subplot(2,2,4);
imshow(decr_img);
title("Decrypted gray-scale image");

sgtitle("Matrix Inversion and Involutory Matrix used to encrypt/decrypt an image");
end