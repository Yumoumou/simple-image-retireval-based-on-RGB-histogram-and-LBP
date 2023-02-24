function [ Uniform_LBP_index ] = get_uniform_lbp(  )
%得到58个uniform lbp值
Uniform_LBP_index = zeros(1,58);
index = 1;
%cnt = 0;%跳变次数
for i=0:255
    bin_num = dec2bin(i,8); %将该数转化为2进制
    len = length(bin_num);
    cnt = 0;
    
    for j = 1:len-1
        if bin_num(j) ~= bin_num(j+1)
            cnt = cnt +1;
        end
    end
   
    if cnt <= 2 %跳变次数大于2 舍弃 小于2 留下
        Uniform_LBP_index(1,index) = i;       
        index = index + 1;
    end
end

