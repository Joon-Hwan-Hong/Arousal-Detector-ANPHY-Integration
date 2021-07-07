clear

%% file paths
addpath('D:\\Project\Project Scripts');
addpath('D:\\Project\multimodal-arousal-detector-master\matlab');
addpath('D:\\Project\multimodal-arousal-detector-master\matlab\resources_matlab');

%% param vars
p_output = 'D:\Project\OUT\';
p_edf = 'D:\Project\Sana\P3\JA5650SL.edf';
des_fs = 128;
dirIndex = paths;
ftype = 'mni';
% target signals and file name
list_signals = [51, 52, 142, 152:157];
file_name = 'JA5650SL.txt';

%% script processes
% load PSG data
[hdr,data] = LoadEDF(p_edf, ftype);

% resampling data
[hdr,data] = preprocess.resampleData(data, hdr, des_fs);

% filtering data
data = preprocess.filterData(data,hdr,1);

% default ini
int_size = int64(size(data,2)/des_fs);
ar_seq = zeros(1,int_size);
W = ar_seq;

% export data
exportData(data, ar_seq, W, hdr, filepath(p_output, file_name));
disp('Preprocessing Pipeline Finished. Now run ar_predict.py script.'); % could make a system call to a python env but (todo)
