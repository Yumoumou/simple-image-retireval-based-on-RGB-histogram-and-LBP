%读入查询图片
query_image = imread(input('输入一个query图像地址：')); %读入一个指定的query图像

%提取query图像的颜色特征
query_color_feature = zeros(1,16,3);%查询图像的颜色特征1*16*3

query_color_feature(:,:,1) =  extract_color(query_image,1);%读入query图像的R (1*16矩阵)
query_color_feature(:,:,2) =  extract_color(query_image,2);%读入query图像的G
query_color_feature(:,:,3) =  extract_color(query_image,3);%读入query图像的B

%读入database图片
database_file_path =  'D:\CIFAR-10\database\';
database_list = dir(strcat(database_file_path,'*.png'));
database_num = length(database_list);

%提取database图像的颜色特征
%database_name = zeros(database_num,1); 
database_color_feature = zeros(database_num,16,3);
cos_sim = zeros(database_num,2); %database图片和query图片的余弦相似度
for i = 1:database_num
    database_name = database_list(i).name; 
    database_image = imread(strcat(database_file_path,database_name)); 
    database_color_feature(i,:,1) =  extract_color(database_image,1);%读入第i个database图像的R
    database_color_feature(i,:,2) =  extract_color(database_image,2);%读入第i个database图像的G
    database_color_feature(i,:,3) =  extract_color(database_image,3);%读入第i个database图像的B
    
    cos_sim_R = cal_cos_sim(database_color_feature(i,:,1),query_color_feature(:,:,1));%第i个database图像的R与query的平均余弦相似度
    cos_sim_G = cal_cos_sim(database_color_feature(i,:,2),query_color_feature(:,:,2));%第i个database图像的G与query的平均余弦相似度
    cos_sim_B = cal_cos_sim(database_color_feature(i,:,3),query_color_feature(:,:,3));%第i个database图像的B与query的平均余弦相似度
    cos_sim(i,2) = i; %记下每张图片对应的相似度，以便排序完成后索引
    cos_sim(i,1) = (cos_sim_R+cos_sim_G+cos_sim_B)/3;
    
end    

sorted_database = sortrows(cos_sim); %对所有database图的相似度进行升序排列，取后20个作为结果

%展示按颜色特征值检索的结果
for i = database_num:-1:database_num-19
    disp(sorted_database(i,1));
    disp(sorted_database(i,2));
end





