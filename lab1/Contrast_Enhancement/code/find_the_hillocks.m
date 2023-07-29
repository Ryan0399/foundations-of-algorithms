function H = find_the_hillocks(B)
    [h, w] = size(B);
    [L, num] = bwlabel(B,4);
    H = cell(1, num);

    for i = 1:num
        ind = find(L == i);
        [r, c] = ind2sub([h, w], ind);
        H(i) = {[r c]};
    end

end
