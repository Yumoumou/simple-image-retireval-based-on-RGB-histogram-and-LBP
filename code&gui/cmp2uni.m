function [ uni_lbp ] = cmp2uni( lbp,Uniform_LBP_index)
%将lbp值与uniform lbp比较 若不属于uniform lbp记为59
%   lbp为1*900 uni_lbp为1*59
uni_lbp = zeros(1,59);
flag = 0;

for j = 1:900
    flag = 0;
    for i=1:58
        if lbp(1,j) == Uniform_LBP_index(1,i)
            uni_lbp(1,i) = uni_lbp(1,i)+1;
            flag = 1;
        end
    end
    if flag == 0 %如果不在uniform LBP里面
        uni_lbp(1,59) = uni_lbp(59) + 1;
    end
end
end



