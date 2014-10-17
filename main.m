
function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 01-May-2013 12:00:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)


%%%%Populate the popImages menu with all the images in the folder

strFolder = './Images';
    
list = dir(strcat(strFolder,'/*.jpg'));
l = length(list);
fname = cell(1,l);
for k=1:length(list)
    fname{k} = strcat(strFolder,'/',list(k).name);
    
end
set(handles.popImages,'String', fname);
% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popImages.
function popImages_Callback(hObject, eventdata, handles)
% hObject    handle to popImages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popImages contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popImages


% --- Executes during object creation, after setting all properties.
function popImages_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popImages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popEnhance.
function popEnhance_Callback(hObject, eventdata, handles)
% hObject    handle to popEnhance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popEnhance contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popEnhance


% --- Executes during object creation, after setting all properties.
function popEnhance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popEnhance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popEnhance.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popEnhance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popEnhance contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popEnhance


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popEnhance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in btLoadImg.
function btLoadImg_Callback(hObject, eventdata, handles)
% hObject    handle to btLoadImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%Load the image
    contents = cellstr(get(handles.popImages,'String'));
    fname = contents{get(handles.popImages,'Value')};
    
    global img;
    global img2;
    img = imresize(imread(fname),[800 600]);
    img2 = img;
    axes(handles.axes1);
    handles.axes1 = imshow(img);
    set(handles.axes1,'ButtonDownFcn',@ImageClickCallback);
    

function ImageClickCallback ( objectHandle , eventData )
global img;
h = figure;
h = imshow(img);

    


% --- Executes on button press in btApplyE.
function btApplyE_Callback(hObject, eventdata, handles)
% hObject    handle to btApplyE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global img;
    global img2;
    if (get(handles.popEnhance,'Value') == 1)
        img2 = img;
    else
        img2 = enhance(img,get(handles.popEnhance,'Value') -1);
    end
    
    axes(handles.axes2);
    handles.axes2 = imshow(img2);
    set(handles.axes2,'ButtonDownFcn',@ImageClickCallback2);
    

function ImageClickCallback2 ( objectHandle , eventData )
%global img2;
h = get(objectHandle,'parent');
F=getframe(h); %select axes in GUI
    figure(); %new figure
    image(F.cdata); %show selected axes in new figure




% --- Executes during object creation, after setting all properties.
function popLocate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popLocate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btLocate.
function btLocate_Callback(hObject, eventdata, handles)
% hObject    handle to btLocate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img2;
global plate;
try
    if (get(handles.popLocate,'Value') == 1)
        axes(handles.axes3);
        plate = PlateIsolation(img2);
        if (~isempty(plate))
            plate = plate{1};
            handles.axes3 = imshow(plate);
            set(handles.axes3,'ButtonDownFcn',@ImageClickCallback2);
        else
            set(handles.edit2,'String','Error');
        end
    else
        imgs = PlateLocalization(img2,get(handles.popLocate,'Value')-1);
        plate = PlateIsolation(img2,imgs{1});
        plate = plate{1};
        axes(handles.axes3);
        handles.axes3 = imshow(plate);
        axes(handles.axes2);
        img2 = imgs{1};
        handles.axes2 = imshow(img2);
        set(handles.axes2,'ButtonDownFcn',@ImageClickCallback2);
    end
catch
    set(handles.edit2,'String','Error');
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


% --- Executes on selection change in popSegmentation.
function popSegmentation_Callback(hObject, eventdata, handles)
% hObject    handle to popSegmentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popSegmentation contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popSegmentation

function popLocate_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function popSegmentation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popSegmentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btSeparate.
function btSeparate_Callback(hObject, eventdata, handles)
% hObject    handle to btSeparate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%Extract the letters in the plate
global plate;
global letters;
  [s1 s2 ~] = size(plate);
    i2 = edge(rgb2gray(plate),'canny',0.3); %increase the edges 

    %separate one letter from another
    se = strel('square',2);
    i3 = imdilate(i2,se);
    i4 = imfill(i3,'holes');

    %Connect components
    [Ilabel num] = bwlabel(i4,4);
    Iprops = regionprops(Ilabel);
    Ibox = [Iprops.BoundingBox];
    Ibox = reshape(Ibox,[4 num]);
    axes(handles.axes3);

    out = cell(1,num); %worse case it will have num images as letter candidates
    for cnt = 1:num
        %the size and area of the image has to make sense...
        %the image was resized to [100 NaN]
        if (Iprops(cnt).Area > 100 && Iprops(cnt).Area < 1000)
            aux = Ibox(:,cnt);
            if ((aux(3) < s2/4) && (aux(4) > s1/3) )
                %w = waitforbuttonpress;
                rectangle('position',Ibox(:,cnt),'edgecolor','r');
                
                out{cnt} = imresize(imcrop(plate, aux),[45 20]);
                %%figure; imshow(subImage);
                
            end
        end
    end
    letters = out(~cellfun(@isempty,out)); %eliminate empty cells




% --- Executes on selection change in popRecognition.
function popRecognition_Callback(hObject, eventdata, handles)
% hObject    handle to popRecognition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popRecognition contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popRecognition


% --- Executes during object creation, after setting all properties.
function popRecognition_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popRecognition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btRecognize.
function btRecognize_Callback(hObject, eventdata, handles)
% hObject    handle to btRecognize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global letters;
if (~isempty(letters))
    axes(handles.axes4);
    s = '';
    for k=1:length(letters)
        handles.axes4 = imshow(letters{k});
        pause(1);
        s = strcat(s,im2char(letters{k}));
        set(handles.edit2,'String',s); 
        
    end
else
   set(handles.edit2,'String','Error'); 
end
