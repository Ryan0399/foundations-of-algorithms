im1 = imread('input_image_1.png');
delta = 4;
%% TODO: 实现论文算法，得到处理后的图像im2（完成Enhance.m，SweepandPush.m两个函数的填充）

% 将彩色图按亮度进行对比度增强，同时保持色度不变
im1 = rgb2xyz(im1); % 转化为亮度
% 色度坐标(x,y)
x = im1(:, :, 1) ./ (im1(:, :, 1) + im1(:, :, 2) + im1(:, :, 3));
y = im1(:, :, 2) ./ (im1(:, :, 1) + im1(:, :, 2) + im1(:, :, 3));
im1Y = im1(:, :, 2);
tic;
im2Y = Enhance(delta, im1Y, 0, 1);
toc;
im2 = zeros(size(im1));
im2(:, :, 2) = im2Y;
im2(:, :, 1) = im2Y .* x ./ y;
im2(:, :, 3) = im2(:, :, 1) ./ x - im2Y - im2(:, :, 1);
im1 = xyz2rgb(im1);
im2 = xyz2rgb(im2);

% 将图像按颜色通道分量分别进行对比度增强
% im2 = uint8(zeros(size(im1)));
% tic;
% 
% for i = 1:size(im1, 3)
%     im2(:, :, i) = Enhance(delta, im1(:, :, i), 0, 255);
% end
% 
% toc;


%% 展示处理前后图像
subplot(121); imshow(im1); title('input image');
subplot(122); imshow(im2); title('output image');
% imwrite(im2, 'delta=10.png');
