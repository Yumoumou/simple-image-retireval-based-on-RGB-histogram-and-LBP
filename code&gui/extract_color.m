function [ color_histogram ] = extract_color( image,c )
%����һ��ͼ�� ���������ɫ����������3*16��
%c��ָ��R/G/B�Ĳ���
%   ��ɫΪRGB,256�Ҷȼ���ÿ16��Ϊһ�飬һ��16�飬
%   ���ó�ÿ����ɫ�������������16������
row = length(image(:,1,c)); %ͼ������
clm = length(image(1,:,c)); %ͼ������

color_histogram = zeros(1,16); 
for i = 1:row
    for j = 1:clm %����ͼ�����������
        color_histogram(1,histogram_group(image(i,j,c))) = color_histogram(1,histogram_group(image(i,j,c))) + 1; 
    end
end

