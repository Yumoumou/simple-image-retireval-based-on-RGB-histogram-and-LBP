function varargout = lbp_gui(varargin)
% LBP_GUI MATLAB code for lbp_gui.fig
%      LBP_GUI, by itself, creates a new LBP_GUI or raises the existing
%      singleton*.
%
%      H = LBP_GUI returns the handle to a new LBP_GUI or the handle to
%      the existing singleton*.
%
%      LBP_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LBP_GUI.M with the given input arguments.
%
%      LBP_GUI('Property','Value',...) creates a new LBP_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lbp_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lbp_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lbp_gui

% Last Modified by GUIDE v2.5 18-Jun-2022 19:06:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lbp_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @lbp_gui_OutputFcn, ...
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


% --- Executes just before lbp_gui is made visible.
function lbp_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lbp_gui (see VARARGIN)

% Choose default command line output for lbp_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lbp_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lbp_gui_OutputFcn(hObject, eventdata, handles) 
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

query_image_show = imread(query_image_path);

axes(handles.axes1);

imshow(query_image_show);

Uniform_LBP_index = get_uniform_lbp();%58种uniform lbp值需要先计算出来 即跳变小于等于2

query_image= rgb2gray(query_image_show);%查询图象转为灰度图

query_lbp = get_lbp(query_image,Uniform_LBP_index); %得到query的lbp特征向量 1*59

%读入database图片
database_file_path =  'D:\CIFAR-10\database\';
database_list = dir(strcat(database_file_path,'*.png'));
database_num = length(database_list);

database_lbp = zeros(database_num,59);%database 的lbp特征向量
cos_sim_lbp = zeros(database_num,2);%余弦相似度

%将database与query相比较
for i = 1:database_num
    database_name = database_list(i).name; 
    database_image =  rgb2gray(imread(strcat(database_file_path,database_name))); 
    database_lbp(i,:) = get_lbp(database_image,Uniform_LBP_index);
    
    %计算该database图与query的相似度
    cos_sim_lbp(i,1) = cal_cos_sim(database_lbp(i,:),query_lbp);
    cos_sim_lbp(i,2) = i;
end
 
sorted_database_lbp = sortrows(cos_sim_lbp); %对所有database图的相似度进行升序排列，取后20个作为结果

%展示按lbp特征检索的结果
    axes(handles.axes2);
    im2 = imread(strcat(database_file_path,database_list(sorted_database_lbp(180,2)).name));
    imshow(im2);

    axes(handles.axes3);
    im3 = imread(strcat(database_file_path,database_list(sorted_database_lbp(179,2)).name));
    imshow(im3);
    
    axes(handles.axes4);
    im4 = imread(strcat(database_file_path,database_list(sorted_database_lbp(178,2)).name));
    imshow(im4);
    
    axes(handles.axes5);
    im5 = imread(strcat(database_file_path,database_list(sorted_database_lbp(177,2)).name));
    imshow(im5);

    axes(handles.axes6);
    im6 = imread(strcat(database_file_path,database_list(sorted_database_lbp(176,2)).name));
    imshow(im6);
    
    axes(handles.axes7);
    im7 = imread(strcat(database_file_path,database_list(sorted_database_lbp(175,2)).name));
    imshow(im7);
    
    axes(handles.axes8);
    im8 = imread(strcat(database_file_path,database_list(sorted_database_lbp(174,2)).name));
    imshow(im8);
    
    axes(handles.axes9);
    im9 = imread(strcat(database_file_path,database_list(sorted_database_lbp(173,2)).name));
    imshow(im9);
    
    axes(handles.axes10);
    im10 = imread(strcat(database_file_path,database_list(sorted_database_lbp(172,2)).name));
    imshow(im10);
    
    axes(handles.axes11);
    im11 = imread(strcat(database_file_path,database_list(sorted_database_lbp(171,2)).name));
    imshow(im11);
    
    axes(handles.axes12);
    im12 = imread(strcat(database_file_path,database_list(sorted_database_lbp(170,2)).name));
    imshow(im12);
    
    axes(handles.axes13);
    im13 = imread(strcat(database_file_path,database_list(sorted_database_lbp(169,2)).name));
    imshow(im13);
    
    axes(handles.axes14);
    im14 = imread(strcat(database_file_path,database_list(sorted_database_lbp(168,2)).name));
    imshow(im14);
    
    axes(handles.axes15);
    im15 = imread(strcat(database_file_path,database_list(sorted_database_lbp(167,2)).name));
    imshow(im15);
    
    axes(handles.axes16);
    im16 = imread(strcat(database_file_path,database_list(sorted_database_lbp(166,2)).name));
    imshow(im16);
    
    axes(handles.axes17);
    im17 = imread(strcat(database_file_path,database_list(sorted_database_lbp(165,2)).name));
    imshow(im17);
    
    axes(handles.axes18);
    im18 = imread(strcat(database_file_path,database_list(sorted_database_lbp(164,2)).name));
    imshow(im18);
    
    axes(handles.axes19);
    im19 = imread(strcat(database_file_path,database_list(sorted_database_lbp(163,2)).name));
    imshow(im19);
    
    axes(handles.axes20);
    im20 = imread(strcat(database_file_path,database_list(sorted_database_lbp(162,2)).name));
    imshow(im20);
    
    axes(handles.axes21);
    im21 = imread(strcat(database_file_path,database_list(sorted_database_lbp(161,2)).name));
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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
