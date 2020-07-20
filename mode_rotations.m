function varargout = mode_rotations(varargin)
% MODE_ROTATIONS MATLAB code for mode_rotations.fig
%      MODE_ROTATIONS, by itself, creates a new MODE_ROTATIONS or raises the existing
%      singleton*.
%
%      H = MODE_ROTATIONS returns the handle to a new MODE_ROTATIONS or the handle to
%      the existing singleton*.
%
%      MODE_ROTATIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODE_ROTATIONS.M with the given input arguments.
%
%      MODE_ROTATIONS('Property','Value',...) creates a new MODE_ROTATIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mode_rotations_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mode_rotations_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mode_rotations

% Last Modified by GUIDE v2.5 21-Jun-2020 13:48:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mode_rotations_OpeningFcn, ...
                   'gui_OutputFcn',  @mode_rotations_OutputFcn, ...
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


% --- Executes just before mode_rotations is made visible.
function mode_rotations_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mode_rotations (see VARARGIN)

% Choose default command line output for mode_rotations
handles.output = hObject;


handles.annotation_eta = annotation(hObject,'textbox',[0.29 0.792 0.06 0.15],'LineStyle','none');
handles.annotation_POD = annotation(hObject,'textbox',[0.085 0.796 0.06 0.15],'LineStyle','none');
handles.annotation_QPOD = annotation(hObject,'textbox',[0.2 0.796 0.06 0.15],'LineStyle','none');

handles.annotation_eta_txt = annotation(hObject,'textbox',[0.26 0.796 0.12 0.15],'LineStyle','none');
handles.annotation_POD_txt = annotation(hObject,'textbox',[0.04 0.796 0.12 0.15],'LineStyle','none');
handles.annotation_QPOD_txt = annotation(hObject,'textbox',[0.15 0.796 0.12 0.15],'LineStyle','none');
eta_info = '$\eta_\textrm{n}$ = ';
set(handles.annotation_eta_txt,'String',eta_info,'Interpreter','Latex','fontsize',12,'fontname','times new roman')
POD_info = ['POD Mode' sprintf('\n') '$\| \phi^u \|$ = ' sprintf('\n')];
POD_info = [POD_info '$\| \phi^v \|$ = ' sprintf('\n')];
POD_info = [POD_info '$\| \phi^w \|$ = ' sprintf('\n')];
set(handles.annotation_POD_txt,'String',POD_info,'Interpreter','Latex','fontsize',12,'fontname','times new roman')
QPOD_info = ['QPOD Mode' sprintf('\n') '$\| \phi^\textrm{rq} \|$ = ' sprintf('\n')];
QPOD_info = [QPOD_info '$\| \phi^\textrm{iq} \|$ = ' sprintf('\n')];
QPOD_info = [QPOD_info '$\| \phi^\textrm{jq} \|$ = ' sprintf('\n')];
QPOD_info = [QPOD_info '$\| \phi^\textrm{kq} \|$ = ' sprintf('\n')];
set(handles.annotation_QPOD_txt,'String',QPOD_info,'Interpreter','Latex','fontsize',12,'fontname','times new roman')


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mode_rotations wait for user response (see UIRESUME)
% uiwait(handles.figure1);

rng(1)

global idx
idx = 1;

set(handles.r_axes,'xtick',[])
set(handles.r_axes,'ytick',[])
set(handles.u_axes,'xtick',[])
set(handles.u_axes,'ytick',[])
set(handles.v_axes,'xtick',[])
set(handles.v_axes,'ytick',[])
set(handles.w_axes,'xtick',[])
set(handles.w_axes,'ytick',[])
set(handles.ur_axes,'xtick',[])
set(handles.ur_axes,'ytick',[])
set(handles.vr_axes,'xtick',[])
set(handles.vr_axes,'ytick',[])
set(handles.wr_axes,'xtick',[])
set(handles.wr_axes,'ytick',[])
handles.new_mode_selection = 1;

updateRotation(handles,1,1)

disableGUI(handles)


% --- Outputs from this function are returned to the command line.
function varargout = mode_rotations_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function r_slider_Callback(hObject, eventdata, handles)
% hObject    handle to r_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

updateRotation(handles,1,1)
updatePlots(handles)

% --- Executes during object creation, after setting all properties.
function r_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function i_slider_Callback(hObject, eventdata, handles)
% hObject    handle to i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

updateRotation(handles,1,2)
updatePlots(handles)

% --- Executes during object creation, after setting all properties.
function i_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function j_slider_Callback(hObject, eventdata, handles)
% hObject    handle to j_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

updateRotation(handles,1,3)
updatePlots(handles)

% --- Executes during object creation, after setting all properties.
function j_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to j_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on selection change in modes_listbox.
function modes_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to modes_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns modes_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from modes_listbox

if ( get(handles.sim_radiobutton,'Value') )
    
    updatePlots(handles)
    
else

r = handles.modes_q.w;
u = handles.modes_q.x;
v = handles.modes_q.y;
w = handles.modes_q.z;
i = get(handles.modes_listbox,'Value');
handles.cmin = min(min([r(:,i) u(:,i) v(:,i) w(:,i)]));
handles.cmax = max(max([r(:,i) u(:,i) v(:,i) w(:,i)]));
handles = updateCaxis(handles);
guidata(hObject, handles);

updatePlots(handles)

end

% --- Executes during object creation, after setting all properties.
function modes_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to modes_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function r_box_Callback(hObject, eventdata, handles)
% hObject    handle to r_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of r_box as text
%        str2double(get(hObject,'String')) returns contents of r_box as a double

updateRotation(handles,2,1)
updatePlots(handles)

% --- Executes during object creation, after setting all properties.
function r_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function i_box_Callback(hObject, eventdata, handles)
% hObject    handle to i_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of i_box as text
%        str2double(get(hObject,'String')) returns contents of i_box as a double

updateRotation(handles,2,2)
updatePlots(handles)

% --- Executes during object creation, after setting all properties.
function i_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to i_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function j_box_Callback(hObject, eventdata, handles)
% hObject    handle to j_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of j_box as text
%        str2double(get(hObject,'String')) returns contents of j_box as a double

updateRotation(handles,2,3)
updatePlots(handles)

% --- Executes during object creation, after setting all properties.
function j_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to j_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in data_menu.
function data_menu_Callback(hObject, eventdata, handles)
% hObject    handle to data_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns data_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from data_menu

% --- Executes during object creation, after setting all properties.
function data_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in play_button.
function play_button_Callback(hObject, eventdata, handles)
% hObject    handle to play_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ( get(hObject,'Value') )
    
    set(hObject,'String','Pause')
    
    global idx

    while( get(hObject,'Value') )
        
        display('simulating')
        updatePlots(handles)
        pause(0.2)
        idx = idx + 1;
        
    end
    
else
    set(hObject,'String','Play')
    
    display('no more')
    
end


% --- Executes on slider movement.
function play_slider_Callback(hObject, eventdata, handles)
% hObject    handle to play_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.play_button,'Value',0)
set(handles.play_button,'String','Play')
i = get(hObject,'Value');
global idx
idx = floor(i*6000);
updatePlots(handles)


% --- Executes during object creation, after setting all properties.
function play_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to play_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function cmin_box_Callback(hObject, eventdata, handles)
% hObject    handle to cmin_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cmin_box as text
%        str2double(get(hObject,'String')) returns contents of cmin_box as a double
handles.cmin = str2double(get(hObject,'String'));
handles = updateCaxis(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function cmin_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmin_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function cmax_box_Callback(hObject, eventdata, handles)
% hObject    handle to cmax_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cmax_box as text
%        str2double(get(hObject,'String')) returns contents of cmax_box as a double

handles.cmax = str2double(get(hObject,'String'));
handles = updateCaxis(handles);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function cmax_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmax_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load_button.
function load_button_Callback(hObject, eventdata, handles)
% hObject    handle to load_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disableGUI(handles)

if (get(handles.data_menu,'Value') == 1)
    
    load('modes_sta0.mat')
    
elseif (get(handles.data_menu,'Value') == 2)
    
    load('modes_sta3.mat')
    
elseif (get(handles.data_menu,'Value') == 3)
    
    load('modes_sta6.mat')

elseif (get(handles.data_menu,'Value') == 4)
    
    load('modes_sta9.mat')
    
elseif (get(handles.data_menu,'Value') == 5)
    
    load('modes_sta12.mat')
    
elseif (get(handles.data_menu,'Value') == 6)
    
    load('modes_sta15.mat')

end

handles.nx = 129;
handles.ny = 28;
handles.modes_q = data_modes_q;
handles.modes_r = data_modes_r;
handles.time_coefs_q = time_coefs_q;
handles.time_coefs_r = time_coefs_r;
handles.Sq = Sq;
handles.Sr = Sr;

colormap(handles.r_axes,'jet')
colormap(handles.u_axes,'jet')
colormap(handles.v_axes,'jet')
colormap(handles.w_axes,'jet')
colormap(handles.ur_axes,'jet')
colormap(handles.vr_axes,'jet')
colormap(handles.wr_axes,'jet')

r = data_modes_q.w;
u = data_modes_q.x;
v = data_modes_q.y;
w = data_modes_q.z;
i = get(handles.modes_listbox,'Value');
if (get(handles.sim_radiobutton,'Value'))
    handles.cmin = -1.5;
    handles.cmax = 1.5;
else
    handles.cmin = min(min([data_modes_r(1:handles.nx*handles.ny,i) data_modes_r(handles.nx*handles.ny+1:2*handles.nx*handles.ny,i) data_modes_r(2*handles.nx*handles.ny+1:end,i) r(:,i) u(:,i) v(:,i) w(:,i)]));
    handles.cmax = max(max([data_modes_r(1:handles.nx*handles.ny,i) data_modes_r(handles.nx*handles.ny+1:2*handles.nx*handles.ny,i) data_modes_r(2*handles.nx*handles.ny+1:end,i) r(:,i) u(:,i) v(:,i) w(:,i)]));
    % handles.cmin = min(min([r(:,i) u(:,i) v(:,i) w(:,i)]));
    % handles.cmax = max(max([r(:,i) u(:,i) v(:,i) w(:,i)]));
end
handles = updateCaxis(handles);
guidata(hObject, handles);

L = sqrt(sum(Sq.^2));
eta_n = sum( (Sq - Sr(1:length(Sq))).^2 )/(2*L^2);
eta_info = sprintf('%.2e\n',eta_n);
set(handles.annotation_eta,'String',eta_info,'Interpreter','Latex','fontsize',12,'fontname','times new roman')
updateRotation(handles,1,1);
updatePlots(handles);
enableGUI(handles)



function enableGUI(handles)
set(handles.r_box,'Enable','on')
set(handles.i_box,'Enable','on')
set(handles.j_box,'Enable','on')
set(handles.r_slider,'Enable','on')
set(handles.i_slider,'Enable','on')
set(handles.j_slider,'Enable','on')
set(handles.modes_listbox,'Enable','on')
set(handles.cmin_box,'Enable','on')
set(handles.cmax_box,'Enable','on')
set(handles.minReal_button,'Enable','on')
set(handles.sim_radiobutton,'Enable','on');
set(handles.modes_radiobutton,'Enable','on');
set(handles.magnitude_button,'Enable','on');
% set(handles.rotation_panel,'Enable','on');
if (get(handles.sim_radiobutton,'Value'))
    set(handles.play_button,'Enable','on');
    set(handles.play_slider,'Enable','on');
    set(handles.fluc_button,'Enable','on');
end


function disableGUI(handles)
set(handles.r_box,'Enable','off')
set(handles.i_box,'Enable','off')
set(handles.j_box,'Enable','off')
set(handles.r_slider,'Enable','off')
set(handles.i_slider,'Enable','off')
set(handles.j_slider,'Enable','off')
set(handles.modes_listbox,'Enable','off')
set(handles.cmin_box,'Enable','off')
set(handles.cmax_box,'Enable','off')
set(handles.minReal_button,'Enable','off')
set(handles.play_button,'Enable','off');
set(handles.play_slider,'Enable','off');
set(handles.sim_radiobutton,'Enable','off');
set(handles.modes_radiobutton,'Enable','off');
set(handles.magnitude_button,'Enable','off');
set(handles.fluc_button,'Enable','off');
% set(handles.rotation_panel,'Enable','off');



function handles = updateCaxis(handles)
set(handles.cmin_text,'String',['Colormap Min' sprintf('\n') num2str(handles.cmin)]);
set(handles.cmax_text,'String',['Colormap Max' sprintf('\n') num2str(handles.cmax)]);
set(handles.cmin_box,'String',num2str(handles.cmin));
set(handles.cmax_box,'String',num2str(handles.cmax));
caxis(handles.r_axes,[handles.cmin handles.cmax])
caxis(handles.u_axes,[handles.cmin handles.cmax])
caxis(handles.v_axes,[handles.cmin handles.cmax])
caxis(handles.w_axes,[handles.cmin handles.cmax])
caxis(handles.ur_axes,[handles.cmin handles.cmax])
caxis(handles.vr_axes,[handles.cmin handles.cmax])
caxis(handles.wr_axes,[handles.cmin handles.cmax])


function updateRotation(handles,type,var)

if (type == 1) % slider moved, update boxes
    
    r_value = get(handles.r_slider,'Value');
    p_value = get(handles.i_slider,'Value');
    t_value = get(handles.j_slider,'Value');
    set(handles.r_box,'String',num2str(r_value));
    set(handles.i_box,'String',num2str(p_value));
    set(handles.j_box,'String',num2str(t_value));
    
elseif (type == 2) % box input changed, update sliders
    
    r_value = str2double(get(handles.r_box,'String'));
    p_value = str2double(get(handles.i_box,'String'));
    t_value = str2double(get(handles.j_box,'String'));
    set(handles.r_slider,'Value',r_value);
    set(handles.i_slider,'Value',p_value);
    set(handles.j_slider,'Value',t_value);
    
end

rotation_str = ['cos(' num2str(r_value) ') + sin(' num2str(r_value) ') (' num2str(cosd(p_value)*cosd(t_value)) 'i + ' num2str(cosd(p_value)*sind(t_value)) 'j + ' num2str(sind(p_value)) 'k)'];
set(handles.rot_text,'String',rotation_str)


function updatePlots(handles)

cla(handles.r_axes)
cla(handles.u_axes)
cla(handles.v_axes)
cla(handles.w_axes)
cla(handles.ur_axes)
cla(handles.vr_axes)
cla(handles.wr_axes)
i = get(handles.modes_listbox,'Value');
nx = handles.nx;
ny = handles.ny;

if ( get(handles.sim_radiobutton,'Value') )
    
        global idx
        
        
        if (get(handles.fluc_button,'Value'))
            
            % Flow Fluctuations
            offset = 1;
            
            % Flow fluctuations with only the average mode
            if (i == 1)
                dontPlot = 1;
            else
                dontPlot = 0;
            end
            
        else
            
            % Full Flow
            offset = 0;
            
        end
        
        % Compute appropriate ROM
        l.w = handles.modes_q.w(:,1+offset:i)*diag(handles.Sq(1+offset:i));
        l.x = handles.modes_q.x(:,1+offset:i)*diag(handles.Sq(1+offset:i));
        l.y = handles.modes_q.y(:,1+offset:i)*diag(handles.Sq(1+offset:i));
        l.z = handles.modes_q.z(:,1+offset:i)*diag(handles.Sq(1+offset:i));
        r.w = handles.time_coefs_q.w(idx,1+offset:i)';
        r.x = handles.time_coefs_q.x(idx,1+offset:i)';
        r.y = handles.time_coefs_q.y(idx,1+offset:i)';
        r.z = handles.time_coefs_q.z(idx,1+offset:i)';
        
        
        ROM_q.w =  -1*(l.w * r.w - l.x * r.x - l.y * r.y - l.z * r.z);
        ROM_q.x =  -1*(l.x * r.w + l.w * r.x - l.z * r.y + l.y * r.z);
        ROM_q.y =  -1*(l.y * r.w + l.z * r.x + l.w * r.y - l.x * r.z);
        ROM_q.z =  -1*(l.z * r.w - l.y * r.x + l.x * r.y + l.w * r.z);
        tmp = handles.modes_r(:,1+offset:i)*diag(handles.Sr(1+offset:i))*handles.time_coefs_r(idx,1+offset:i)';
        ROM_r.x = tmp(1:nx*ny);
        ROM_r.y = tmp(nx*ny+1:2*nx*ny);
        ROM_r.z = tmp(2*nx*ny+1:3*nx*ny);
        
        
        if (get(handles.magnitude_button,'Value'))
            % Magnitude simulation
            magR = ((ROM_r.x).^2 + (ROM_r.y).^2 + (ROM_r.z).^2).^(0.5);
            magQ = ((ROM_q.w).^2 + (ROM_q.x).^2 + (ROM_q.y).^2 + (ROM_q.z).^2).^(0.5);
            
            imagesc(handles.ur_axes,transpose(reshape(magR,[nx ny])));
            imagesc(handles.u_axes,transpose(reshape(magQ,[nx ny])));
            
            set(handles.vr_axes,'Visible','off')
            set(handles.wr_axes,'Visible','off')
            set(handles.r_axes,'Visible','off')
            set(handles.v_axes,'Visible','off')
            set(handles.w_axes,'Visible','off')
            
        else
            % Component simulation
            
            imagesc(handles.r_axes,transpose(reshape(ROM_q.w,[nx ny])));
            imagesc(handles.u_axes,transpose(reshape(ROM_q.x,[nx ny])));
            imagesc(handles.v_axes,transpose(reshape(ROM_q.y,[nx ny])));
            imagesc(handles.w_axes,transpose(reshape(ROM_q.z,[nx ny])));
            
            imagesc(handles.ur_axes,transpose(reshape(ROM_r.x,[nx ny])));
            imagesc(handles.vr_axes,transpose(reshape(ROM_r.y,[nx ny])));
            imagesc(handles.wr_axes,transpose(reshape(ROM_r.z,[nx ny])));
        end
        
        % updateCaxis(handles);
        set(handles.play_slider,'Value',idx/6000);
        
else         
    % Mode Plots
    
    % Magnitude plot
    if (get(handles.magnitude_button,'Value'))
        
        
        mode_r.x = handles.modes_r(1:nx*ny,i);
        mode_r.y = handles.modes_r(nx*ny+1:2*nx*ny,i);
        mode_r.z = handles.modes_r(2*nx*ny+1:3*nx*ny,i);
        mode_q.w = handles.modes_q.w(:,i);
        mode_q.x = handles.modes_q.x(:,i);
        mode_q.y = handles.modes_q.y(:,i);
        mode_q.z = handles.modes_q.z(:,i);
        
        magR = ((mode_r.x).^2 + (mode_r.y).^2 + (mode_r.z).^2).^(0.5);
        magQ = ((mode_q.w).^2 + (mode_q.x).^2 + (mode_q.y).^2 + (mode_q.z).^2).^(0.5);
        
        imagesc(handles.ur_axes,transpose(reshape(magR,[nx ny])));
        imagesc(handles.u_axes,transpose(reshape(magQ,[nx ny])));
        
        set(handles.vr_axes,'Visible','off')
        set(handles.wr_axes,'Visible','off')
        set(handles.r_axes,'Visible','off')
        set(handles.v_axes,'Visible','off')
        set(handles.w_axes,'Visible','off')

    else
    
    % Components
    angle = get(handles.r_slider,'Value');
    p_value = get(handles.i_slider,'Value');
    t_value = get(handles.j_slider,'Value');
    
    r.w = cosd(angle);
    r.x = sind(angle)*cosd(p_value)*cosd(t_value);
    r.y = sind(angle)*cosd(p_value)*sind(t_value);
    r.z = sind(angle)*sind(p_value);
    l.w = handles.modes_q.w(:,i);
    l.x = handles.modes_q.x(:,i);
    l.y = handles.modes_q.y(:,i);
    l.z = handles.modes_q.z(:,i);
    
    mode_q.w =  -1*(l.w * r.w - l.x * r.x - l.y * r.y - l.z * r.z);
    mode_q.x =  -1*(l.x * r.w + l.w * r.x - l.z * r.y + l.y * r.z);
    mode_q.y =  -1*(l.y * r.w + l.z * r.x + l.w * r.y - l.x * r.z);
    mode_q.z =  -1*(l.z * r.w - l.y * r.x + l.x * r.y + l.w * r.z);
    mode_r = handles.modes_r(:,i);
    
    
    norm_r = norm(mode_q.w,'fro');
    norm_i = norm(mode_q.x,'fro');
    norm_j = norm(mode_q.y,'fro');
    norm_k = norm(mode_q.z,'fro');
    QPOD_info = [sprintf('\n') sprintf('%f\n',norm_r)];
    QPOD_info = [QPOD_info sprintf('%f\n',norm_i)];
    QPOD_info = [QPOD_info sprintf('%f\n',norm_j)];
    QPOD_info = [QPOD_info sprintf('%f\n',norm_k)];
    set(handles.annotation_QPOD,'String',QPOD_info,'fontsize',13,'fontname','times new roman')
    norm_u = norm(mode_r(1:handles.nx*handles.ny));
    norm_v = norm(mode_r(handles.nx*handles.ny+1:2*handles.nx*handles.ny));
    norm_w = norm(mode_r(2*handles.nx*handles.ny+1:end));
    POD_info = [sprintf('\n') sprintf('%f\n',norm_u)];
    POD_info = [POD_info sprintf('%f\n',norm_v)];
    POD_info = [POD_info sprintf('%f\n',norm_w)];
    set(handles.annotation_POD,'String',POD_info,'fontsize',12,'fontname','times new roman')
    
    
    imagesc(handles.r_axes,transpose(reshape(mode_q.w,[nx ny])));
    imagesc(handles.u_axes,transpose(reshape(mode_q.x,[nx ny])));
    imagesc(handles.v_axes,transpose(reshape(mode_q.y,[nx ny])));
    imagesc(handles.w_axes,transpose(reshape(mode_q.z,[nx ny])));

    imagesc(handles.ur_axes,transpose(reshape(mode_r(1:nx*ny),[nx ny])));
    imagesc(handles.vr_axes,transpose(reshape(mode_r(nx*ny+1:2*nx*ny),[nx ny])));
    imagesc(handles.wr_axes,transpose(reshape(mode_r(2*nx*ny+1:end),[nx ny])));

    end
    
end

colormap(handles.r_axes,'jet')
colormap(handles.u_axes,'jet')
colormap(handles.v_axes,'jet')
colormap(handles.w_axes,'jet')
colormap(handles.ur_axes,'jet')
colormap(handles.vr_axes,'jet')
colormap(handles.wr_axes,'jet')
set(handles.r_axes,'xtick',[])
set(handles.r_axes,'ytick',[])
set(handles.u_axes,'xtick',[])
set(handles.u_axes,'ytick',[])
set(handles.v_axes,'xtick',[])
set(handles.v_axes,'ytick',[])
set(handles.w_axes,'xtick',[])
set(handles.w_axes,'ytick',[])
set(handles.ur_axes,'xtick',[])
set(handles.ur_axes,'ytick',[])
set(handles.vr_axes,'xtick',[])
set(handles.vr_axes,'ytick',[])
set(handles.wr_axes,'xtick',[])
set(handles.wr_axes,'ytick',[])


% % --- Executes on button press in match_button.
% function match_button_Callback(hObject, eventdata, handles)
% % hObject    handle to match_button (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% i = get(handles.modes_listbox,'Value');
% mode_r = handles.modes_r(:,i);
% mode_q.w = handles.modes_q.w(:,i);
% mode_q.x = handles.modes_q.x(:,i);
% mode_q.y = handles.modes_q.y(:,i);
% mode_q.z = handles.modes_q.z(:,i);
% 
% nx = handles.nx;
% ny = handles.ny;
% R.w = zeros(nx*ny,1);
% R.x = mode_r(1:nx*ny);
% R.y = mode_r(nx*ny+1:2*nx*ny);
% R.z = mode_r(2*nx*ny+1:end);
% 
% q0 = [rand,rand,rand,rand]';
% params.R = R;
% params.mode = mode_q;
% [rot, fval] = runnested1(params,q0);
% fval
% 
% r_value = acosd(rot(1));
% p_value = asind(rot(4)/sind(r_value));
% t_value = acosd(rot(2)/(sind(r_value)*cosd(p_value)));
% % asind(rot.y/(sind(r_value)*cosd(p_value)))
% set(handles.r_box,'String',num2str(r_value));
% set(handles.i_box,'String',num2str(p_value));
% set(handles.j_box,'String',num2str(t_value));
% 
% updateRotation(handles,2,[])
% updatePlots(handles)


% --- Executes on button press in minReal_button.
function minReal_button_Callback(hObject, eventdata, handles)
% hObject    handle to minReal_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

i = get(handles.modes_listbox,'Value');
mode_q.w = handles.modes_q.w(:,i);
mode_q.x = handles.modes_q.x(:,i);
mode_q.y = handles.modes_q.y(:,i);
mode_q.z = handles.modes_q.z(:,i);

nx = handles.nx;
ny = handles.ny;

q0 = [rand,rand,rand,rand]';
params.mode = mode_q;
[rot, fval] = runnested2(params,q0);
fval

r_value = acosd(rot(1));
p_value = asind(rot(4)/sind(r_value));
t_value = acosd(rot(2)/(sind(r_value)*cosd(p_value)));
% asind(rot.y/(sind(r_value)*cosd(p_value)))
set(handles.r_box,'String',num2str(r_value));
set(handles.i_box,'String',num2str(p_value));
set(handles.j_box,'String',num2str(t_value));

updateRotation(handles,2,[])
updatePlots(handles)


% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


display(get(handles.modes_radiobutton,'Value'))
if (get(handles.sim_radiobutton,'Value'))
    
    set(hObject,'String','Simulation')
    set(handles.play_button,'Enable','on');
    set(handles.play_slider,'Enable','on');
    set(handles.fluc_button,'Enable','on');
    set(handles.minReal_button,'Enable','off');
    set(handles.r_box,'Enable','off');
    set(handles.i_box,'Enable','off');
    set(handles.j_box,'Enable','off');
    set(handles.r_slider,'Enable','off');
    set(handles.i_slider,'Enable','off');
    set(handles.j_slider,'Enable','off');
    handles.cmin = -1.5;
    handles.cmax = 1.5;
    
else
    
    set(hObject,'String','Modes')
    set(handles.play_button,'Enable','off');
    set(handles.play_slider,'Enable','off');
    set(handles.fluc_button,'Enable','off');
    set(handles.minReal_button,'Enable','on');
    set(handles.r_box,'Enable','on');
    set(handles.i_box,'Enable','on');
    set(handles.j_box,'Enable','on');
    set(handles.r_slider,'Enable','on');
    set(handles.i_slider,'Enable','on');
    set(handles.j_slider,'Enable','on');

%     i = get(handles.modes_listbox,'Value');
%     handles.cmin = min(min([data_modes_r(1:handles.nx*handles.ny,i) data_modes_r(handles.nx*handles.ny+1:2*handles.nx*handles.ny,i) data_modes_r(2*handles.nx*handles.ny+1:end,i) r(:,i) u(:,i) v(:,i) w(:,i)]));
%     handles.cmax = max(max([data_modes_r(1:handles.nx*handles.ny,i) data_modes_r(handles.nx*handles.ny+1:2*handles.nx*handles.ny,i) data_modes_r(2*handles.nx*handles.ny+1:end,i) r(:,i) u(:,i) v(:,i) w(:,i)]));
    
end
handles = updateCaxis(handles);
guidata(hObject, handles);
updatePlots(handles)


% --- Executes on button press in magnitude_button.
function magnitude_button_Callback(hObject, eventdata, handles)
% hObject    handle to magnitude_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of magnitude_button

if (get(hObject,'Value'))
    set(hObject,'String','Magnitude')
    set(handles.vr_axes,'Visible','on')
    set(handles.wr_axes,'Visible','on')
    set(handles.r_axes,'Visible','on')
    set(handles.v_axes,'Visible','on')
    set(handles.w_axes,'Visible','on')
    
    set(get(handles.vr_axes,'children'),'visible','on')
    set(get(handles.wr_axes,'children'),'visible','on')
    set(get(handles.r_axes,'children'),'visible','on')
    set(get(handles.v_axes,'children'),'visible','on')
    set(get(handles.w_axes,'children'),'visible','on')
    
    set(handles.r_box,'Enable','on')
    set(handles.i_box,'Enable','on')
    set(handles.j_box,'Enable','on')
    set(handles.r_slider,'Enable','on')
    set(handles.i_slider,'Enable','on')
    set(handles.j_slider,'Enable','on')
    
else
    
    set(get(handles.vr_axes,'children'),'visible','off')
    set(get(handles.wr_axes,'children'),'visible','off')
    set(get(handles.r_axes,'children'),'visible','off')
    set(get(handles.v_axes,'children'),'visible','off')
    set(get(handles.w_axes,'children'),'visible','off')
    
    set(hObject,'String','Components')
    set(handles.vr_axes,'Visible','off')
    set(handles.wr_axes,'Visible','off')
    set(handles.r_axes,'Visible','off')
    set(handles.v_axes,'Visible','off')
    set(handles.w_axes,'Visible','off')
    
    set(handles.r_box,'Enable','off')
    set(handles.i_box,'Enable','off')
    set(handles.j_box,'Enable','off')
    set(handles.r_slider,'Enable','off')
    set(handles.i_slider,'Enable','off')
    set(handles.j_slider,'Enable','off')
    
end

updatePlots(handles)


% --- Executes on button press in fluc_button.
function fluc_button_Callback(hObject, eventdata, handles)
% hObject    handle to fluc_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fluc_button

if (get(hObject,'Value'))
    set(hObject,'String','Fluctuations')
else
    set(hObject,'String','Full Flow')
end

updatePlots(handles)

% --- Executes on button press in modes_radiobutton.
function modes_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to modes_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of modes_radiobutton

updatePlots(handles)
