% All rights reserved: the group of zhanglei，chenyujie & baijin
% Can mail us : mathcoder@163.com
function [ lambda ] = solve_lambda( laplace, p, lambda, r )
%SOLVE_LAMBDA 此处显示有关此函数的摘要
%   此处显示详细说明

lambda = lambda + r*(p-laplace);
end

