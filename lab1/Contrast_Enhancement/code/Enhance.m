function imout = Enhance(delta, im, L, U)
    %   此函数输入论文中阈值delta，图片im，像素值上下界L,U，得到处理后的图片imout
    P = local_minimas_points(im, 0.01);
    imout = im;
    imout = SweepandPush(imout, P, delta, U);
    imout = U - imout;
    Q = local_minimas_points(imout, 0.01);
    imout = SweepandPush(imout, Q, delta, U);
    imout = U - imout;
end
