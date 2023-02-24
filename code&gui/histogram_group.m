function [ group_num ] = histogram_group( x )
%判断该像素的颜色的R/G/B分量在第几组（一共16组）
%  其中第1组为[0,15]，则第i组为[0+16*(i-1), 15+16*(i-1)]

for i = 1:16
    if x >= 0 + 16*(i-1) && x<= 15 + 16*(i-1)
        group_num = i;
        break;
    end
end

