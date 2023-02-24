function [ group_num ] = histogram_group( x )
%�жϸ����ص���ɫ��R/G/B�����ڵڼ��飨һ��16�飩
%  ���е�1��Ϊ[0,15]�����i��Ϊ[0+16*(i-1), 15+16*(i-1)]

for i = 1:16
    if x >= 0 + 16*(i-1) && x<= 15 + 16*(i-1)
        group_num = i;
        break;
    end
end

