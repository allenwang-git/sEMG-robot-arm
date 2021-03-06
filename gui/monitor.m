function varargout = monitor(varargin)
% MONITOR MATLAB code for monitor.fig
%      MONITOR, by itself, creates a new MONITOR or raises the existing
%      singleton*.
%
%      H = MONITOR returns the handle to a new MONITOR or the handle to
%      the existing singleton*.
%
%      MONITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MONITOR.M with the given input arguments.
%
%      MONITOR('Property','Value',...) creates a new MONITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before monitor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to monitor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help monitor

% Last Modified by GUIDE v2.5 19-Apr-2020 21:09:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @monitor_OpeningFcn, ...
    'gui_OutputFcn',  @monitor_OutputFcn, ...
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


% --- Executes just before monitor is made visible.
function monitor_OpeningFcn(hObject, eventdata, handles, varargin)
% 界面初始化函数
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to monitor (see VARARGIN)


% Choose default command line output for monitor
handles.output = hObject;
global flag;
flag=0;
h=timer;   %设置定时器
handles.he=h;   %定义句柄
%set(handles.he,'ExecutionMode','singleShot');  %定时器只执行一次，定一次时。
set(handles.he,'ExecutionMode','fixedRate');   %定时器，循环执行，循环定时。
set(handles.he,'Period',1);    %定时器，定时间隔 1秒
set(handles.he,'TimerFcn',{@disptime,handles});  %定时器，定时会触发 TimerFcn 函数，定时函数(TimerFcn)触发用户自定义的函数(disptime函数)
start(handles.he);   %开启定时器
%% 界面初始化
axes(handles.axes12);
imshow(imread('gui/neu.jpg'));
axes(handles.axes3);
imshow(imread('gui/relax1.jpg'));
axes(handles.axes4);
imshow(imread('gui/open1.jpg'));
axes(handles.axes5);
imshow(imread('gui/index1.jpg'));
axes(handles.axes6);
imshow(imread('gui/grasp1.jpg'));
axes(handles.axes7);
imshow(imread('gui/middle1.jpg'));
axes(handles.axes7);
set(handles.edit1,'string','正常','foregroundcolor',[0,0,0]);

%% 初始化arduino
global a ;
fclose(instrfind); % 关闭已打开的串口
a=arduino('com3');

astatus=1;
if astatus
    set(handles.edit2,'string','正常','foregroundcolor',[0,0,0]);
    pause(1);
    set(handles.edit3,'string','正常','foregroundcolor',[0,0,0]);
end
servoAttach(a,7);servoAttach(a,8);servoAttach(a,9);
servoAttach(a,10);servoAttach(a,11);% 连接机械手
servoWrite(a,7,40);servoWrite(a,8,140);servoWrite(a,9,140);
servoWrite(a,10,140);servoWrite(a,11,40);% 初始化机械手

%% Update handles structure
guidata(hObject, handles);

% UIWAIT makes monitor wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% 自定义的函数，将edit控件的内容改成当前时间。定时器，定时会触发该函数
function disptime(hObject, eventdata, handles)
% 界面时间显示函数
set(handles.edit5,'String',datestr(now));   % 将edit5控件的内容改成当前时间

% --- Outputs from this function are returned to the command line.
function varargout = monitor_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in startbutton.
function startbutton_Callback(hObject, eventdata, handles)
% hObject    handle to startbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic

% 设置程序启动状态
global flag a;

set(handles.startbutton,'backgroundcolor',[0.53,0.94,0.42]);

%% 利用训练好的分类模型对未知数据进行预测
model=libsvmload('D:/MATLAB2019/Workspace/sEMG/v3.0/copymodel.model',27);% 加载分类模型
sr=load('D:/MATLAB2019/Workspace/sEMG/v3.0/rule.mat');%加载归一化规则
st=load('moni.mat');
nr=fieldnames(sr);
rule=getfield(sr,char(nr));
test=getfield(st,char(fieldnames(st)));

%采用滑动窗思想，截取一段时间窗length_t,滑动窗大小delta_t,单位ms
length_t=100;
delta_t=20;
m=1; % 决策次数

xx=0;
for i=1:delta_t:size(test,1)
    % 跳出循环条件
    if i+length_t>size(test,1)
        break;
    elseif flag==1
        waitforbuttonpress; % 暂停
    end
    drawnow();% 感知全局变量变化
    
    result(m)=g_testemg(model,rule,test,i,length_t);% 分类结果
    
    v1=get(handles.sleft,'value');
    v2=get(handles.sright,'value');
    if v1==1
        % 绘制预测结果图20*length(result)
        if mod(m,10)==0
            axes(handles.axes1);
            stairs(0.20*(m-10):0.20:0.20*(m-1),result(m-9:m),'r.','markersize',20);
            pause(0.001);% 刷新图像
            set(gca,'ytick',0:1:4);% 设置y轴步长
            axis([0.01*xx 0.01*(xx+2000) 0 4]);% 设置坐标轴范围
            set(gca,'yticklabel',{'relax','open','middle','index','grasp'});
            xlabel('t/s');
            hold on;
            grid on;
        end
    end
    % 可视化显示   
    if v2==1
        % 绘制原始数据图
        axes(handles.axes2);
        x=(i:i+delta_t); % 设置x轴
        plot(0.01*x,test(i:i+delta_t,2),'b');
        axis([0.01*xx 0.01*(xx+2000) -0.7 0.5]);
        xlabel('t/s');
        pause(0.001);% 刷新图像
        hold on;
        grid on;
    end
    
    if xx+2000-i<50
        xx=xx+50;% 滚动显示
    end
    
    if mod(m,6)==0
        axes(handles.axes8);
        switch result(m)
            case 0
                servoWrite(a,7,40);servoWrite(a,8,140);servoWrite(a,9,140);
                servoWrite(a,10,140);servoWrite(a,11,40);  % 控制机械手
                set(handles.edit6,'string','放松');   % 显示识别结果
                imshow(imread('gui/relax.jpg'));
            case 1
                servoWrite(a,7,0);servoWrite(a,8,180);servoWrite(a,9,180);
                servoWrite(a,10,180);servoWrite(a,11,0);
                set(handles.edit6,'string','伸掌');
                imshow(imread('gui/open.jpg'));
            case 3
                servoWrite(a,7,100);servoWrite(a,8,100);servoWrite(a,9,180);
                servoWrite(a,10,180);servoWrite(a,11,0);
                set(handles.edit6,'string','捏食指');
                imshow(imread('gui/index.jpg'));
            case 4
                servoWrite(a,7,100);servoWrite(a,8,100);servoWrite(a,9,80);
                servoWrite(a,10,80);servoWrite(a,11,100);
                set(handles.edit6,'string','握拳');
                imshow(imread('gui/grasp.jpg'));
            case 2
                servoWrite(a,7,100);servoWrite(a,8,180);servoWrite(a,9,80);
                servoWrite(a,10,180);servoWrite(a,11,0);
                set(handles.edit6,'string','捏中指');
                imshow(imread('gui/middle.jpg'));
        end
    end
    m=m+1;
end


% Hint: get(hObject,'Value') returns toggle state of startbutton

function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 设置程序启动状态
global flag a;

set(handles.startbutton,'backgroundcolor',[0.53,0.94,0.42]);

%利用训练好的分类模型对未知数据进行预测
model=libsvmload('D:/MATLAB2019/Workspace/copymodel.model',27);% 加载分类模型
sr=load('D:/MATLAB2019/Workspace/sEMG/v3.0/rule.mat');%加载归一化规则
st=load('moni.mat');
nr=fieldnames(sr);
rule=getfield(sr,char(nr));
test=getfield(st,char(fieldnames(st)));

%采用滑动窗思想，截取一段时间窗length_t,滑动窗大小delta_t,单位ms
length_t=100;
delta_t=20;
m=1; % 决策次数

xx=0;
for i=1:delta_t:size(test,1)
    % 跳出循环条件
    if i+length_t>size(test,1)
        break;
    elseif flag==1
        waitforbuttonpress; % 暂停
    end
    drawnow();% 感知全局变量变化
    
    result(m)=g_testemg(model,rule,test,i,length_t);% 分类结果
    
    v1=get(handles.sleft,'value');
    v2=get(handles.sright,'value');
    if v1==1
        % 绘制预测结果图20*length(result)
        if mod(m,10)==0
            axes(handles.axes1);
            stairs(20*(m-10):20:20*(m-1),result(m-9:m),'r.','markersize',20);
            pause(0.001);% 刷新图像
            set(gca,'ytick',0:1:6);% 设置y轴步长
            axis([xx xx+2000 0 6]);% 设置坐标轴范围
            hold on;
            grid on;
        end
        
    end
    if v2==1
        % 绘制原始数据图
        axes(handles.axes2);
        x=(i:i+delta_t); % 设置x轴
        plot(x,test(i:i+delta_t,2),'b');
        axis([xx xx+2000 -0.7 0.5]);
        pause(0.001);% 刷新图像
        hold on;
        grid on;
    end
    if xx+2000-i<50
        xx=xx+50;% 滚动显示
    end
    
    % 显示分类结果
    axes(handles.axes8);
    
    switch result(m)
        case 0
            servoWrite(a,7,40);servoWrite(a,8,140);servoWrite(a,9,140);
            servoWrite(a,10,140);servoWrite(a,11,40);% 控制机械手
            set(handles.edit6,'string','放松');
            imshow(imread('gui/relax.jpg'));
        case 1
            servoWrite(a,7,0);servoWrite(a,8,180);servoWrite(a,9,180);
            servoWrite(a,10,180);servoWrite(a,11,0);
            set(handles.edit6,'string','伸掌');
            imshow(imread('gui/open.jpg'));
        case 3
            servoWrite(a,7,100);servoWrite(a,8,100);servoWrite(a,9,180);
            servoWrite(a,10,180);servoWrite(a,11,0);
            set(handles.edit6,'string','捏食指');
            imshow(imread('gui/index.jpg'));
        case 4
            servoWrite(a,7,100);servoWrite(a,8,100);servoWrite(a,9,80);
            servoWrite(a,10,80);servoWrite(a,11,100);
            set(handles.edit6,'string','握拳');
            imshow(imread('gui/grasp.jpg'));
        case 2
            servoWrite(a,7,100);servoWrite(a,8,180);servoWrite(a,9,80);
            servoWrite(a,10,180);servoWrite(a,11,0);
            set(handles.edit6,'string','捏中指');
            imshow(imread('gui/middle.jpg'));
    end
    m=m+1;
end

% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% 设置程序暂停状态
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global flag;
flag=1;
set(handles.togglebutton2,'backgroundcolor','r');
set(handles.pushbutton1,'backgroundcolor',[0.94 0.94 0.94]);

% --------------------------------------------------------------------
function quit_Callback(hObject, eventdata, handles)
% hObject    handle to quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;

function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes4

% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes4



% --- Executes during object creation, after setting all properties.
function axes5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes5


% --- Executes during object creation, after setting all properties.
function axes6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes6

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



% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_6_Callback(hObject, eventdata, handles)
% 菜单栏帮助
% hObject    handle to Untitled_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg('东北大学机器人学院本科毕设 By 王一诺','System Info');



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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 设置程序暂停状态
global flag;
flag=1;
set(handles.togglebutton2,'backgroundcolor','r');
set(handles.pushbutton1,'backgroundcolor',[0.94 0.94 0.94]);


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global flag;
flag=0;
set(handles.togglebutton2,'backgroundcolor',[0.94 0.94 0.94]);
set(handles.pushbutton1,'backgroundcolor',[0.53,0.94,0.42]);


% --- Executes on button press in sleft.
function sleft_Callback(hObject, eventdata, handles)
% show left 按钮
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v1=get(handles.sleft,'value');
switch v1
    case 1
        set(handles.sleft,'backgroundcolor',[0.53,0.94,0.42]);
    case 0
        set(handles.sleft,'backgroundcolor',[0.94 0.94 0.94]);
end


% --- Executes on button press in sright.
function sright_Callback(hObject, eventdata, handles)
% show right按钮
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v2=get(handles.sright,'value');
switch v2
    case 1
        set(handles.sright,'backgroundcolor',[0.53,0.94,0.42]);
    case 0
        set(handles.sright,'backgroundcolor',[0.94 0.94 0.94]);
end


% --------------------------------------------------------------------
function Untitled_7_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global flag;
flag=0;
set(handles.togglebutton2,'backgroundcolor',[0.94 0.94 0.94]);
set(handles.pushbutton1,'backgroundcolor',[0.53,0.94,0.42]);
