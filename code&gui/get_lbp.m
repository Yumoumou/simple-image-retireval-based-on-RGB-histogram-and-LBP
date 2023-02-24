function [ lbp ] = get_lbp( image,Uniform_LBP_index)
%imageΪ�Ҷ�ͼ 32*32  lbpΪ1*59������uniform��
row = length(image(:,1)); %��
clm = length(image(1,:)); %��
lbp0 = zeros(1,900);%���1024�����ص��lbpֵ
cnt = 1;
I0 = zeros(1,8); %lbpֵ�Ķ�����
for i = 2 : row-1
    for j = 2 : clm-1
        c = image(i, j);%����
        %��������ȡ1������ȡ0
        I0(1) = image(i-1, j-1) >= c;
        I0(2) = image(i-1, j) >= c;
        I0(3) = image(i-1, j+1) >= c; 
        I0(4) = image(i, j+1) >= c;
        I0(5) = image(i+1, j+1) >= c;
        I0(6) = image(i+1, j)>=c; 
        I0(7) = image(i+1, j-1)>=c; 
        I0(8) = image(i, j-1)>=c;
        %�õ�lbpֵ
        lbp0(1,cnt) = I0(1) *2^7 + I0(2) * 2^6 + I0(3) * 2^5 + I0(4) * 2^4 + I0(5) * 2^3 + I0(6) * 2^2 + I0(7) * 2^1 + I0(8) * 2^0;
        cnt = cnt + 1;
    end
end

%���õ���lbpֵ��uniform_lbp�Ƚ� �ó���������
lbp = cmp2uni(lbp0,Uniform_LBP_index);
end

