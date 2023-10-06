function [A, varargout] = construct_involutory_matrix(r, varargin)
%CONSTRUCT_INVOLUTORY_MATRIX Function to create an involutory matrix to
%be used for cryptography applcation.
%   This function construct the envolutory_matrix used to encrypt and
%   decrypt an input image. The following parameters are rewquired:
%   1. r is the size of each block of the involutory matrix
%   2. varargin is a variable number of input parameters. It is used to
%   pass:
%       2.1 an existing A22 block (the key) 
%       2.2 the constant scalar k 
%   The output of these functions are:
%   1. A is the involutory matrix used to encrypt or decrypt the image
%   2. varargout is used to return a variable number of parameters. In
%   particular, it is used to pass:
%       2.1 the A22 block (the key) 
%       2.2 the constant scalar k

% if the user has not pass the key and k-value, means that we are encrypt
% the image, so we need to generate a new key and a new scalar k. Then we
% will pass in output the new key value and k.
if numel(varargin) == 0
    k = rand;
    A22 = rand(r,r);
    varargout{1} = k;
    varargout{2} = A22;
else 
    % in this case, the user pass an existing key and k value, so we are in
    % the decrypting phase and we only need to construct the involutory
    % matrix to decrypt the image.
    k = varargin{1};
    A22 = varargin{2};
end

A11 = -A22;
A12 = k* eye(r,r);
A21 = 1/k* eye(r,r) * (eye(r,r)-A11*A11);

A = [A11, A12;
    A21, A22];
end