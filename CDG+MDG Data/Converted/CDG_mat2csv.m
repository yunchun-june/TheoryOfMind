clc;
clear all;

%this is an example of how to read the data

files = dir('*.mat');
fileNum = length(files);

for i = 1:fileNum
    data = load(files(i).name);
    result = data.toSave;
    
    fileName = ['./csv/' files(i).name(1:13) '.csv'];
    cell2csv(fileName, result);
end