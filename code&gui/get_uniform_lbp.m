function [ Uniform_LBP_index ] = get_uniform_lbp(  )
%�õ�58��uniform lbpֵ
Uniform_LBP_index = zeros(1,58);
index = 1;
%cnt = 0;%�������
for i=0:255
    bin_num = dec2bin(i,8); %������ת��Ϊ2����
    len = length(bin_num);
    cnt = 0;
    
    for j = 1:len-1
        if bin_num(j) ~= bin_num(j+1)
            cnt = cnt +1;
        end
    end
   
    if cnt <= 2 %�����������2 ���� С��2 ����
        Uniform_LBP_index(1,index) = i;       
        index = index + 1;
    end
end

