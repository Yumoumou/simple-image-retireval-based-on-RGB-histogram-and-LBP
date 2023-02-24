function [ cossim ] = cal_cos_sim( data,query)
%计算两个图像特征向量的余弦相似度
%  data_color是1*16 query_color也是1*16
%  若是lbp特征的话 则两向量均为1*59
    mag_data = sqrt(sum(data.*data));%data颜色特征向量的模
    mag_query = sqrt(sum(query.*query));%query颜色特征向量的模
    
cossim = dot(data,query) / (mag_data * mag_query);
end

