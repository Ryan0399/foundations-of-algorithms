function im2 = SweepandPush(im, S, delta, U)
    %S为"驻点"处的函数值集合，Sweep这些函数值，进行"Push"，处理后图像为im2
    [h, w] = size(im);
    im2 = im;
    delta_h = zeros(h, w); % 存储对应位置的历史净比例缩放因子
    n = length(S);

    for i = 1:n
        b = S(i);
        [row, col] = find(im >= b);
        B = full(sparse(row, col, ones(length(row), 1), h, w));
        H = find_the_hillocks(B); % 查找B中的山丘集合
        num = size(H, 2);

        for j = 1:num
            index = H{j};
            m = size(index, 1);
            p_max = index(1, :);

            for k = 2:m

                if im(p_max(1), p_max(2)) < im(index(k, 1), index(k, 2))
                    p_max = index(k, :);
                end

            end

            delta_max = min(delta, (U - b) / (im(p_max(1), p_max(2)) - b) - 1.0);

            for k = 1:m
                delta_apply = delta_max;

                if delta_apply + delta_h(index(k, 1), index(k, 2)) > delta
                    delta_apply = delta - delta_h(index(k, 1), index(k, 2));
                end

                im2(index(k, 1), index(k, 2)) = max((1 + delta_apply) * (im(index(k, 1), index(k, 2)) - b) + b, im2(index(k, 1), index(k, 2)));
                delta_h(index(k, 1), index(k, 2)) = delta_h(index(k, 1), index(k, 2)) + delta_apply;
            end

        end

    end

end
