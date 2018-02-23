clc;

colName = cell(1,18);
colName{1} =     'trial_num';
colName{2} =     'dictator';
colName{3} =     'disrupted';
colName{4} =     'p1get';
colName{5} =     'p2get';
colName{6} =     'p1get_ori';
colName{7} =     'p2get_ori';
colName{8} =     'score1';
colName{9} =     'score2';
colName{10} =    'score3';
colName{11} =    'allocateRT';
colName{12} =    's1RT';
colName{13} =    's2RT';
colName{14} =    's3RT';
colName{15} =    'answered_allocate';
colName{16} =    'answered_s1';
colName{17} =    'answered_s2';
colName{18} =    'answered_s3';

files = dir( 'MDG*.mat');
fileNum = length(files);
for i = 1:fileNum
    filename = files(i).name;
    load(filename);
    trial = length(result);
    toSave = cell(trial+1,14);
    for col = 1:18
        toSave{1,col} = colName{col};
    end
    
    for row = 1:trial 
        for col = 1:18
            toSave{row+1,col} = result{row,col};
        end
    end
    
    prefix = ['./Converted/' filename(1:10)];
    index = filename(length(filename)-5);
    saveFilename = [prefix index];
    save(saveFilename,'toSave');
    
end

