function [ cossim ] = cal_cos_sim( data,query)
%��������ͼ�������������������ƶ�
%  data_color��1*16 query_colorҲ��1*16
%  ����lbp�����Ļ� ����������Ϊ1*59
    mag_data = sqrt(sum(data.*data));%data��ɫ����������ģ
    mag_query = sqrt(sum(query.*query));%query��ɫ����������ģ
    
cossim = dot(data,query) / (mag_data * mag_query);
end

