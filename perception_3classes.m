clear;
clc;
% 创建数据
X = [-1 -1; 0 0; 1 1]';
X1 = [X; ones(1, size(X, 2))]; 

%% 感知器学习
w = [0 0 0; 1 0 0; 0 0 0]';
maxstep = 100;
lr = 0.5;
iter = 0;
for step = 1:maxstep
    errors = 0;
    for i = 1:size(X, 2)
        flag = 0;
        d = w' * X1(:, i);
        t = get_t(i + 1);
        if d(i) - d(t) <= 0
            flag = 1;
            w(:, t) = w(:, t) - lr .* X1(:, i);
        end
        t = get_t(i + 2);
        if d(i) - d(t) <= 0
            flag = 1;
            w(:, t) = w(:, t) - lr .* X1(:, i);
        end
        if flag == 1
            w(:, i) = w(:, i) + lr .* X1(:, i);
            errors = errors + 1;
        end
        draw_func(X, w, step);
    end
    if errors == 0
        break;
    end
end

%% 得到t
function n = get_t(i)
    if i > 3
        n = mod(i, 3);
    else
        n = i;
    end
end

%% 绘制分类线
function draw_func(X, w, step)
    figure(1);
    clf;
    hold on;
    scatter(X(1, 1), X(2, 1), 'filled', 'MarkerFaceColor', 'b');
    scatter(X(1, 2), X(2, 2), 'filled', 'MarkerFaceColor', 'r');
    scatter(X(1, 3), X(2, 3), 'filled', 'MarkerFaceColor', 'm');
    x = -3:0.1:3;
    y1 = -(w(1, 1) * x + w(3, 1)) / w(2, 1);
    y2 = -(w(1, 2) * x + w(3, 2)) / w(2, 2);
    y3 = -(w(1, 3) * x + w(3, 3)) / w(2, 3);
    d12 = y1 - y2;
    d23 = y2 - y3;
    d31 = y3 - y1;
    plot(x, d12);
    plot(x, d23);
    plot(x, d31);
    legend('class1', 'class2', 'class3', 'd12', 'd23', 'd31');
    xlabel('X');
    ylabel('Y');
    title(['Two-Dimensional Scatter Plot', ' iterations=', num2str(step)])
    hold off;
end