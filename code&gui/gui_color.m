function varargout = gui_color(varargin)
% GUI_COLOR MATLAB code for gui_color.fig
%      GUI_COLOR, by itself, creates a new GUI_COLOR or raises the existing
%      singleton*.
%
%      H = GUI_COLOR returns the handle to a new GUI_COLOR or the handle to
%      the existing singleton*.
%
%      GUI_COLOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_COLOR.M with the given input arguments.
%
%      GUI_COLOR('Property','Value',...) creates a new GUI_COLOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_color_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_color_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_color

% Last Modified by GUIDE v2.5 18-Jun-2022 21:28:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_color_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_color_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui_color is made visible.
function gui_color_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_color (see VARARGIN)

% Choose default command line output for gui_color
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_color wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_color_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
query_image_path = get(handles.edit1,'String');

query_image = imread(query_image_path);

axes(handles.axes1);

imshow(query_image);

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
    axes(handles.axes2);
    im2 = imread(strcat(database_file_path,database_list(sorted_database(180,2)).name));
    imshow(im2);

    axes(handles.axes3);
    im3 = imread(strcat(database_file_path,database_list(sorted_database(179,2)).name));
    imshow(im3);
    
    axes(handles.axes4);
    im4 = imread(strcat(database_file_path,database_list(sorted_database(178,2)).name));
    imshow(im4);
    
    axes(handles.axes5);
    im5 = imread(strcat(database_file_path,database_list(sorted_database(177,2)).name));
    imshow(im5);

    axes(handles.axes6);
    im6 = imread(strcat(database_file_path,database_list(sorted_database(176,2)).name));
    imshow(im6);
    
    axes(handles.axes7);
    im7 = imread(strcat(database_file_path,database_list(sorted_database(175,2)).name));
    imshow(im7);
    
    axes(handles.axes8);
    im8 = imread(strcat(database_file_path,database_list(sorted_database(174,2)).name));
    imshow(im8);
    
    axes(handles.axes9);
    im9 = imread(strcat(database_file_path,database_list(sorted_database(173,2)).name));
    imshow(im9);
    
    axes(handles.axes10);
    im10 = imread(strcat(database_file_path,database_list(sorted_database(172,2)).name));
    imshow(im10);
    
    axes(handles.axes11);
    im11 = imread(strcat(database_file_path,database_list(sorted_database(171,2)).name));
    imshow(im11);
    
    axes(handles.axes12);
    im12 = imread(strcat(database_file_path,database_list(sorted_database(170,2)).name));
    imshow(im12);
    
    axes(handles.axes13);
    im13 = imread(strcat(database_file_path,database_list(sorted_database(169,2)).name));
    imshow(im13);
    
    axes(handles.axes14);
    im14 = imread(strcat(database_file_path,database_list(sorted_database(168,2)).name));
    imshow(im14);
    
    axes(handles.axes15);
    im15 = imread(strcat(database_file_path,database_list(sorted_database(167,2)).name));
    imshow(im15);
    
    axes(handles.axes16);
    im16 = imread(strcat(database_file_path,database_list(sorted_database(166,2)).name));
    imshow(im16);
    
    axes(handles.axes17);
    im17 = imread(strcat(database_file_path,database_list(sorted_database(165,2)).name));
    imshow(im17);
    
    axes(handles.axes18);
    im18 = imread(strcat(database_file_path,database_list(sorted_database(164,2)).name));
    imshow(im18);
    
    axes(handles.axes19);
    im19 = imread(strcat(database_file_path,database_list(sorted_database(163,2)).name));
    imshow(im19);
    
    axes(handles.axes20);
    im20 = imread(strcat(database_file_path,database_list(sorted_database(162,2)).name));
    imshow(im20);
    
    axes(handles.axes21);
    im21 = imread(strcat(database_file_path,database_list(sorted_database(161,2)).name));
    imshow(im21);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
