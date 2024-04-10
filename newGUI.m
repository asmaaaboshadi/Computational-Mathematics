function varargout = newGUI(varargin)
% NEWGUI MATLAB code for newGUI.fig
%      NEWGUI, by itself, creates a new NEWGUI or raises the existing
%      singleton*.
%
%      H = NEWGUI returns the handle to a new NEWGUI or the handle to
%      the existing singleton*.
%
%      NEWGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEWGUI.M with the given input arguments.
%
%      NEWGUI('Property','Value',...) creates a new NEWGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before newGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to newGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help newGUI

% Last Modified by GUIDE v2.5 18-May-2023 04:15:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @newGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @newGUI_OutputFcn, ...
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


% --- Executes just before newGUI is made visible.
function newGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no show1 args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to newGUI (see VARARGIN)

% Choose default command line show1 for newGUI
handles.output = hObject;

set(handles.show1,'visible','off');
set(handles.table,'visible','off');
set(handles.num,'visible','on');
set(handles.text35,'visible','on');
set(handles.text36,'visible','off');
set(handles.points,'visible','on');

set(handles.uipanel1,'visible','off');
set(handles.uipanel2,'visible','off');
set(handles.uipanel3,'visible','off');
set(handles.uipanel4,'visible','off');
set(handles.uipanel5,'visible','off');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes newGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = newGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning show1 args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line show1 from handles structure
varargout{1} = handles.show1;



function num_Callback(hObject, eventdata, handles)
n = str2double(get(hObject,'string'));
% n = get(hObject,'string');
handles.n = n ;
handles.n
guidata(hObject, handles);
% hObject    handle to num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num as text
%        str2double(get(hObject,'String')) returns contents of num as a double


% --- Executes during object creation, after setting all properties.
function num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in show1.
function show1_Callback(hObject, eventdata, handles)
set(handles.table,'visible','on');
set(handles.uipanel1,'visible','on');
set(handles.uipanel2,'visible','on');
set(handles.uipanel3,'visible','on');
set(handles.uipanel4,'visible','on');
set(handles.uipanel5,'visible','on');
set(handles.text36,'visible','off');
set(handles.show1,'visible','off');

data = get(handles.table, 'Data');
% data(:)

n = handles.n ;
x = zeros(1,n) ;
y = zeros(1,n);
% x = str2double( data(2) );
% x
% y = data(:13) ;
i=1;
X_sum=0;
Y_sum=0;
X2_sum=0;
XY_sum=0;

% X=linspace(x(1),x(end),1000);
% Y=linspace(y(1),y(end),1000);
%calculate sum of X & Y & X^2 & XY
i=1;
while i<=n
    x(i) = str2double(data(i));
    y(i) = str2double(data(13+i));
    X_sum = X_sum+x(i);
    X2_sum=X2_sum+x(i).*x(i);
    Y_sum=Y_sum+y(i);
    XY_sum=XY_sum+x(i).*y(i);
    i=i+1;
end
x
y
X=linspace(x(1),x(end),1000);
Y=linspace(y(1),y(end),1000);

%solving 2 eqns in 2 unknowns to get a0L & a1L
I = [n X_sum;X_sum X2_sum];
O = [Y_sum; XY_sum];
sol = linsolve(I,O);
a0=sol(1);
a1=sol(2);
Y_Linear=a0+a1.*X;


%calculating St & Sr to get R^2
i=1;
S_r=0;
S_t=0;
Y_avg=Y_sum/n;
while i<=n
    e_i=y(i)-a0-a1.*x(i);
    S_r=S_r+e_i.^2;
    S_t=S_t+(y(i)-Y_avg).^2;
    i=i+1;
end
R_Squared_Linear=(S_t-S_r)/S_t;

set(handles.a0L, 'String',strcat('a0 : ',num2str(a0)));
set(handles.a1L, 'String',strcat('a1 : ',num2str(a1)));
set(handles.equL, 'String',strcat('Y = ',num2str(a0) ,' +',num2str(a1),'X'));

plot(handles.axes1,x,y,'ro','linewidth',1.5)
hold(handles.axes1,'on')
plot(handles.axes1,X,Y_Linear,'k','linewidth',1.5)
grid(handles.axes1,'on')

%Exponential Model
%calculate sum of X & Y & X^2 & XY
i=1;
X_sum=0;
Y_sum=0;
X2_sum=0;
XY_sum=0;
Y_Exponential = log(y);
while i<=n
    X_sum = X_sum+x(i);
    X2_sum=X2_sum+x(i).^2;
    Y_sum=Y_sum+Y_Exponential(i);
    XY_sum=XY_sum+x(i).*Y_Exponential(i);
    i=i+1;
end


%solving 2 eqns in 2 unknowns to get a0L & a1L & a &b
I = [n X_sum;X_sum X2_sum];
O = [Y_sum; XY_sum];
sol = linsolve(I,O);
a0=sol(1);
a1=sol(2);
a=exp(a0);
b=a1;
Y_EXP =a.*exp(b.*X);

%calculating St & Sr to get R^2
i=1;
S_r=0;
S_t=0;
Y_avg=Y_sum/n;
while i<=n
    e_i=Y_Exponential(i)-a0-a1.*x(i);
    S_r=S_r+e_i.^2;
    S_t=S_t+(Y_Exponential(i)-Y_avg).^2;
    i=i+1;
end
R_Squared_Exponential=(S_t-S_r)/S_t;

set(handles.a0E, 'String',strcat('a0 : ',num2str(a0)));
set(handles.a1E, 'String',strcat('a1 : ',num2str(a1)));
set(handles.aE, 'String',strcat('a : ',num2str(a)));
set(handles.bE, 'String',strcat('b : ',num2str(b)));

set(handles.equE, 'String',strcat('Y = ',num2str(a) ,' e^',num2str(b),'X'));

plot(handles.axes4,x,y,'ro','linewidth',1.5)
hold(handles.axes4,'on')
plot(handles.axes4,X,Y_EXP,'k','linewidth',1.5)
grid(handles.axes4,'on')

%Power Model
%calculate sum of X & Y & X^2 & XY
i=1;
X_sum=0;
Y_sum=0;
X2_sum=0;
XY_sum=0;
X_power = log10(x);
Y_Power = log10(y);
while i<=n
    X_sum = X_sum+X_power(i);
    X2_sum=X2_sum+X_power(i).^2;
    Y_sum=Y_sum+Y_Power(i);
    XY_sum=XY_sum+X_power(i).*Y_Power(i);
    i=i+1;
end

%solving 2 eqns in 2 unknowns to get a0L & a1L & a &b
I = [n X_sum;X_sum X2_sum];
O = [Y_sum; XY_sum];
sol = linsolve(I,O);
a0=sol(1);
a1=sol(2);
a=10^(a0);
b=a1;
Y_P =a.*X.^b;

%calculating St & Sr to get R^2
i=1;
S_r=0;
S_t=0;
Y_avg=Y_sum/n;
while i<=n
    e_i=Y_Power(i)-a0-a1.*X_power(i);
    S_r=S_r+e_i.^2;
    S_t=S_t+(Y_Power(i)-Y_avg).^2;
    i=i+1;
end
R_Squared_Power=(S_t-S_r)/S_t;

set(handles.a0P, 'String',strcat('a0 : ',num2str(a0)));
set(handles.a1P, 'String',strcat('a1 : ',num2str(a1)));
set(handles.aP, 'String',strcat('a : ',num2str(a)));
set(handles.bP, 'String',strcat('b : ',num2str(b)));

set(handles.equP, 'String',strcat('Y = ',num2str(a) ,' X^',num2str(b)));

plot(handles.axes2,x,y,'ro','linewidth',1.5)
hold(handles.axes2,'on')
plot(handles.axes2,X,Y_P,'k','linewidth',1.5)
grid(handles.axes2,'on')
%Growth Rate Model
%calculate sum of X & Y & X^2 & XY
i=1;
X_sum=0;
Y_sum=0;
X2_sum=0;
XY_sum=0;
X_Growth = 1./x;
Y_Growth = 1./y;
while i<=n
    X_sum = X_sum+X_Growth(i);
    X2_sum=X2_sum+X_Growth(i).^2;
    Y_sum=Y_sum+Y_Growth(i);
    XY_sum=XY_sum+X_Growth(i).*Y_Growth(i);
    i=i+1;
end

%solving 2 eqns in 2 unknowns to get a0L & a1L & a &b
I = [n X_sum;X_sum X2_sum];
O = [Y_sum; XY_sum];
sol = linsolve(I,O);
a0=sol(1);
a1=sol(2);
a=1/a0;
b=a1*a;
Y_G =a.*X./(b+X);

%calculating St & Sr to get R^2
i=1;
S_r=0;
S_t=0;
Y_avg=Y_sum/n;
while i<=n
    e_i=Y_Growth(i)-a0-a1.*X_Growth(i);
    S_r=S_r+e_i.^2;
    S_t=S_t+(Y_Growth(i)-Y_avg).^2;
    i=i+1;
end
R_Squared_Growth=(S_t-S_r)/S_t;

set(handles.a0G, 'String',strcat('a0 : ',num2str(a0)));
set(handles.a1G, 'String',strcat('a1 : ',num2str(a1)));
set(handles.aG, 'String',strcat('a : ',num2str(a)));
set(handles.bG, 'String',strcat('b : ',num2str(b)));
set(handles.equG, 'String',strcat('Y = ',num2str(a) ,'X/(',num2str(b),')+X'));

set(handles.RL, 'String',strcat('R Squared : ',num2str(R_Squared_Linear)));
set(handles.RE, 'String',strcat('R Squared : ',num2str(R_Squared_Exponential)));
set(handles.RP, 'String',strcat('R Squared : ',num2str(R_Squared_Power)));
set(handles.RG, 'String',strcat('R Squared : ',num2str(R_Squared_Growth)));

set(handles.RL2, 'String',strcat('R Squared Linear : ',num2str(R_Squared_Linear)));
set(handles.RE2, 'String',strcat('R Squared Exp : ',num2str(R_Squared_Exponential)));
set(handles.RP2, 'String',strcat('R Squared Power : ',num2str(R_Squared_Power)));
set(handles.RG2, 'String',strcat('R Squared Growth : ',num2str(R_Squared_Growth)));

if (R_Squared_Linear > R_Squared_Exponential) && (R_Squared_Linear > R_Squared_Power) && (R_Squared_Linear > R_Squared_Growth)
    set(handles.best, 'String','THE LINEAR MODEL');
elseif (R_Squared_Exponential > R_Squared_Linear) && (R_Squared_Exponential > R_Squared_Power) && (R_Squared_Exponential > R_Squared_Growth)
    set(handles.best, 'String','THE EXPONENTIAL MODEL');
elseif (R_Squared_Power > R_Squared_Linear) && (R_Squared_Power > R_Squared_Exponential) && (R_Squared_Power > R_Squared_Growth)
    set(handles.best, 'String','THE POWER MODEL');
elseif (R_Squared_Growth > R_Squared_Linear) && (R_Squared_Growth > R_Squared_Exponential) && (R_Squared_Growth > R_Squared_Power)
    set(handles.best, 'String','THE GROWTH MODEL');
end

plot(handles.axes3,x,y,'ro','linewidth',1.5)
hold(handles.axes3,'on')
plot(handles.axes3,X,Y_G,'k','linewidth',1.5)
grid(handles.axes3,'on')

% hObject    handle to show1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in points.
function points_Callback(hObject, eventdata, handles)
if isnan(handles.n) ~= 1
    set(handles.table,'visible','on');
    set(handles.num,'visible','off');
    set(handles.text35,'visible','off');
    set(handles.text36,'visible','on');
    set(handles.points,'visible','off');
    set(handles.show1,'visible','on');

end

% hObject    handle to points (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected cell(s) is changed in table.
function table_CellSelectionCallback(hObject, eventdata, handles)
% S = vartype('numeric');

% fig = handles.table;
% uit = uitable(fig,'Data',[1 2 ; 4 5 ; 7 8 ]);
% uit.FontSize = 10;
% uit

% t = get(hObject,'String') ;
% t

% hObject    handle to table (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in table.
function table_CellEditCallback(hObject, eventdata, handles)

% hObject    handle to table (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
