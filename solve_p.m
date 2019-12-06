% All rights reserved: the group of zhanglei，chenyujie & baijin
% Can mail us : mathcoder@163.com
function [ p ] = solve_p( laplace, lambda, r )
%SOLVE_P 此处显示有关此函数的摘要
%   此处显示详细说明

w = laplace - lambda/r;
p = max(1 - 1/r./abs(w), 0).*w;
end

