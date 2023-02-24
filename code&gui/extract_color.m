function [ color_histogram ] = extract_color( image,c )
%输入一个图像 输出它的颜色特征向量（3*16）
%c是指定R/G/B的参数
%   颜色为RGB,256灰度级，每16个为一组，一共16组，
%   最后得出每组颜色的像素数，输出16个数字
row = length(image(:,1,c)); %图像行数
clm = length(image(1,:,c)); %图像列数

color_histogram = zeros(1,16); 
for i = 1:row
    for j = 1:clm %遍历图像的所有像素
        color_histogram(1,histogram_group(image(i,j,c))) = color_histogram(1,histogram_group(image(i,j,c))) + 1; 
    end
end

