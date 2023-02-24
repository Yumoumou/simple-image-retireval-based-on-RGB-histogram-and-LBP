%�����ѯͼƬ
query_image = imread(input('����һ��queryͼ���ַ��')); %����һ��ָ����queryͼ��

%��ȡqueryͼ�����ɫ����
query_color_feature = zeros(1,16,3);%��ѯͼ�����ɫ����1*16*3

query_color_feature(:,:,1) =  extract_color(query_image,1);%����queryͼ���R (1*16����)
query_color_feature(:,:,2) =  extract_color(query_image,2);%����queryͼ���G
query_color_feature(:,:,3) =  extract_color(query_image,3);%����queryͼ���B

%����databaseͼƬ
database_file_path =  'D:\CIFAR-10\database\';
database_list = dir(strcat(database_file_path,'*.png'));
database_num = length(database_list);

%��ȡdatabaseͼ�����ɫ����
%database_name = zeros(database_num,1); 
database_color_feature = zeros(database_num,16,3);
cos_sim = zeros(database_num,2); %databaseͼƬ��queryͼƬ���������ƶ�
for i = 1:database_num
    database_name = database_list(i).name; 
    database_image = imread(strcat(database_file_path,database_name)); 
    database_color_feature(i,:,1) =  extract_color(database_image,1);%�����i��databaseͼ���R
    database_color_feature(i,:,2) =  extract_color(database_image,2);%�����i��databaseͼ���G
    database_color_feature(i,:,3) =  extract_color(database_image,3);%�����i��databaseͼ���B
    
    cos_sim_R = cal_cos_sim(database_color_feature(i,:,1),query_color_feature(:,:,1));%��i��databaseͼ���R��query��ƽ���������ƶ�
    cos_sim_G = cal_cos_sim(database_color_feature(i,:,2),query_color_feature(:,:,2));%��i��databaseͼ���G��query��ƽ���������ƶ�
    cos_sim_B = cal_cos_sim(database_color_feature(i,:,3),query_color_feature(:,:,3));%��i��databaseͼ���B��query��ƽ���������ƶ�
    cos_sim(i,2) = i; %����ÿ��ͼƬ��Ӧ�����ƶȣ��Ա�������ɺ�����
    cos_sim(i,1) = (cos_sim_R+cos_sim_G+cos_sim_B)/3;
    
end    

sorted_database = sortrows(cos_sim); %������databaseͼ�����ƶȽ����������У�ȡ��20����Ϊ���

%չʾ����ɫ����ֵ�����Ľ��
for i = database_num:-1:database_num-19
    disp(sorted_database(i,1));
    disp(sorted_database(i,2));
end





