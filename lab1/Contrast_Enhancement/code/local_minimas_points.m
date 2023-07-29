function S = local_minimas_points(im, k)
    s = im(find(islocalmin(im)));
    s = sort(s);
    S = [s(1)];

    for i = 2:length(s)

        if s(i) - S(end) >= k
            S(end + 1) = s(i);
        end

    end

end
