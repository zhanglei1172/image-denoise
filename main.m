% All rights reserved: the group of zhanglei，chenyujie & baijin
% Can mail us : mathcoder@163.com
%%
clc, clearvars, close all
%% input 
steps = 500;
r = 2;
alpha = 4;
Im = imread('19-12-03 16-58-28 4495.png');

% Im = imread('19-12-03 16-58-31 4496.jpg');
%%
U0 = im2double(Im);
% add noise
% U0 = U0 + 0.1*randn(size(U0));
% initialize
lambda = 0.5;
U = U0;
const = alpha/r;
filter = [0 1 0; 1 -4 1; 0 1 0];
filter2 = [
    0 0 1 0 0
    0 2 -8 2 0
    1 -8 20+const -8 1
    0 2 -8 2 0
    0 0 1 0 0
    ];
[m, n, D] = size(U0);
size2D = [m, n];
otf = psf2otf(filter2, size2D);
tmp = alpha+r*abs(otf).^2;
F_U0 = fft2(U0);
% p = imfilter(U, filter, 'replicate');
for i = 1:steps
    laplace =h imfilter(U, filter, 'circula');

    p = solve_p( laplace, lambda, r );
    lambda = solve_lambda( laplace, p, lambda, r );
%     U = real(ifft2( (alpha*F_U0+r*fft2(imfilter(p + lambda/r, filter,'circula')))...
%     ./ tmp));
    U = real(ifft2(fft2(const*U0+imfilter(p + lambda/r, filter,'circula'))./otf));
%     r = r*2;
%     U = solve_U(U0, alpha, r, imfilter(p + lambda/r, filter,'replicate'));
end
subplot(121)
imshow(U0,[])
title('input')
subplot(122)
imshow(U,[])
title('output')
m_ax = max(U(:));
m_in = min(U(:));
U = (U-m_in)/(m_ax-m_in);

% subplot(131)
% imshow(Im)
% title('origin')
% subplot(132)
% imshow(U0)
% title('input')
% subplot(133)
% imshow(U)
% title('output')
