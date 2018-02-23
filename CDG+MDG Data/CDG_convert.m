clc;

colName = cell(1,13);
colName{1} =     'trials';
colName{2} =     'p1choice';
colName{3} =     'p1guess';
colName{4} =     'p2choice';
colName{5} =     'p2guess';
colName{6} =     'realSum';
colName{7} =     'p1IsRight';
colName{8} =     'p2IsRight';
colName{9} =     'winner';
colName{10} =    'p1score';
colName{11} =    'p2score';
colName{12} =    'p1events';
colName{13} =    'p2events';

files = dir( 'CDG*.mat');
fileNum = length(files);
for i = 1:fileNum
    filename = files(i).name;
    result = load(filename);
    result = result.result.result;
    trial = length(result);
    toSave = cell(trial+1,11);
    for col = 1:11
        toSave{1,col} = colName{col};
    end
    
    for row = 1:trial 
        for col = 1:11
            toSave{row+1,col} = result{row,col};
        end
    end
    
    prefix = ['./Converted/' filename(1:10)];
    index = filename(length(filename)-5);
    saveFilename = [prefix index];
    save(saveFilename,'toSave');
    
end

