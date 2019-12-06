% All rights reserved: the group of zhanglei，chenyujie & baijin
% Can mail us : mathcoder@163.com
function [ U ] = solve_U1( U0, alpha, r, L_t)
% solve U problem
const = alpha/r;
[m, n] = size(U0);
b = const*U0(:)+L_t(:);
num = m*n; %变量个数
A = spalloc(num, num, 13*num); %%% 按列排 %%%
rem = uint64(0);
for i = 1:num
    rem = rem+1;
    A(i, i) = 20+const;
%     out = 0;
    if rem > m
        rem = rem - m; % [1, m]
    end
    % 上边界1（最外侧）
    if rem > 2
        A(i, i-2) = 1;
    else
        A(i, i-2+m) = 1;
%         out = out-1;
    end
    if rem+1 < m
        A(i, i+2) = 1;
    else
        A(i, i+2-m) = 1;
%         out = out-1;
    end
    if rem ~= 1
        A(i, i-1) = -8;
    else
        A(i, i-1+m) = -8;
%         out = out+8;
    end
    if rem < m
        A(i, i+1) = -8;
    else
        A(i, i+1-m) = -8;
%         out = out+8;
    end
    
    if i>2*m
        A(i, i-2*m) = 1;
    else
        A(i, i-2*m+num) = 1;
%         out = out-1;
    end
    if i+2*m<=num
        A(i, i+2*m) = 1;
    else
        A(i, i+2*m-num) = 1;
%         out = out-1;
    end
    if i>m
        A(i, i-m) = -8;
    else
        A(i, i-m+num) = -8;
%         out = out+8;
    end
    if i+m<=num
        A(i, i+m) = -8;
    else
        A(i, i+m-num) = -8;
%         out = out+8;
    end

    if i-1>m
        A(i, i-m-1) = 2;
    else
        A(i, i-m-1+num) = 2;
%         out = out-2;
    end
    if i+1>m
        A(i, i-m+1) = 2;
    else
        A(i, i-m+1+num) = 2;
%         out = out-2;
    end
    if i+m-1<=num
        A(i, i+m-1) = 2;
    else
        A(i, i+m-1-num) = 2;
%         out = out-2;
    end
    if i+m+1<=num
        A(i, i+m+1) = 2;
    else
        A(i, i+m+1-num) = 2;
%         out = out-2;
    end
%     if out ~= 0
%         b(i) = b(i) + out*U0(i);
%     end
    
end

U = reshape(A\b, m, n);

end
