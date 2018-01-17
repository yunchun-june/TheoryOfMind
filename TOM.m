clear all;
close all;
clc;
addpath('./Functions');
Screen('Preference', 'SkipSyncTests', 1);

try
    %===== Constants =====%
    TRUE                = 1;
    FALSE               = 0;
    
    %===== Constants =====%
    CDG_practiceTrial       = 5;
    CDG_realExpTrial        = 45;
    MDG_practiceTrial       = 5;
    MDG_realExpTrial        = 45;
    displayerOn             = TRUE;
    
    %===== IP Config for 505 ===%
    myID = input('This seat: ','s');
    oppID = input('Opp seat: ','s');
    fprintf('cmd to open terminal. "IPConfig" to get IP (the one with 172.16.10.xxx)\n');
    myIP = input('This IP: ','s');
    myIP = strcat('172.16.10.',myIP);
    oppIP = input('Opp IP: ','s');
    oppIP = strcat('172.16.10.',oppIP);
    myPort = 5454;
    oppPort = 5454;
    if myID(2) == 'a' | myID(2)=='A'
        rule = 'player1';
    else
        rule = 'player2';
    end
    
%     %===== IP Config for developing ===%
%     myIP = 'localhost';
%     oppIP = 'localhost';
% 
%     rule = input('Rule(player1/player2): ','s');
%     assert( strcmp(rule,'player1')|strcmp(rule,'player2'));
%     if strcmp(rule,'player1')
%         myID = 'test_player1';
%         oppID = 'test_player2';
%         %myIP = '192.168.1.83';
%         %oppIP = '192.168.1.42';
%         myPort = 5656;
%         oppPort = 7878;
%     end
%     if(strcmp(rule,'player2'))
%         myID = 'test_player2';
%         oppID = 'test_player1';
%         %myIP = '192.168.1.42';
%         %oppIP = '192.168.1.83';
%         myPort = 7878;
%         oppPort = 5656;
%     end
    
    %===== Initialize Componets =====%
    keyboard    = keyboardHandler();
    displayer   = displayer(max(Screen('Screens')),displayerOn);
    
    %===== Establish Connection =====% 
    cnt = connector(rule,myID, oppID,myIP,myPort,oppIP,oppPort);
    cnt.establish(myID,oppID);
    if displayerOn
        ListenChar(2);
        HideCursor();
    end
    
    %===== Open Screen =====% 
    displayer.openScreen(); 
    
    CDG_practice    = CDG(keyboard, displayer, cnt,rule,myID,oppID,CDG_practiceTrial,FALSE);
    CDG_real        = CDG(keyboard, displayer, cnt,rule,myID,oppID,CDG_realExpTrial,TRUE);
    MDG_practice    = MDG(keyboard, displayer, cnt,rule,myID,oppID,MDG_practiceTrial,FALSE);
    MDG_real        = MDG(keyboard, displayer, cnt,rule,myID,oppID,MDG_realExpTrial,TRUE);
    
    displayer.writeMessage('Wait for instruction','Do not touch any key');
    fprintf('Wait for instruction. Press space to start.\n');
    keyboard.waitSpacePress();
    displayer.blackScreen();
    WaitSecs(1);
    
    %===== Practice of CDG =====% 
    displayer.writeMessage('Practice of Experiment 1','Press space to start');
    fprintf('Practice of Experimen 1,Press space to start\n');
    keyboard.waitSpacePress();
    displayer.blackScreen();

    CDG_practice.run();
    
    displayer.writeMessage('End of Practice','');
    fprintf('End of practice 1.\n');
    WaitSecs(5);
    displayer.blackScreen();
    WaitSecs(1);
    
    %===== Real Experiment of CDG =====% 
    displayer.writeMessage('This is the real Experiment','Press space to start');
    fprintf('Real Experiment,Press space to start\n');
    keyboard.waitSpacePress();
    displayer.blackScreen();
    
    CDG_real.run();
    
    displayer.writeMessage('End of Experiment (Phase1)','Wait for instructions');
    fprintf('End of Experiment 1.\n');
    keyboard.waitSpacePress();
    displayer.blackScreen();
    
    %===== Practice of MDG =====% 
    displayer.writeMessage('Practice of Experiment 2','Press space to start');
    fprintf('Practice of Experimen 2,Press space to start\n');
    keyboard.waitSpacePress();
    displayer.blackScreen();

    MDG_practice.run();
    
    displayer.writeMessage('End of Practice','');
    fprintf('End of practice 2.\n');
    WaitSecs(5);
    displayer.blackScreen();
    WaitSecs(1);
    
    %===== Real Experiment of MDG =====% 
    displayer.writeMessage('This is the real Experiment','Press space to start');
    fprintf('Real Experiment,Press space to start\n');
    keyboard.waitSpacePress();
    displayer.blackScreen();
    
    MDG_real.run();
    
    displayer.writeMessage('End of Experiment (Phase2)','Wait for instructions');
    fprintf('End of Experiment 2.\n');
    keyboard.waitSpacePress();
    displayer.blackScreen();
    
    %===== Clean up =====% 
    displayer.closeScreen();
    ListenChar();
    ShowCursor();
    fprintf('----END OF EXPERIMENT----\n');
    
catch exception
    fprintf(1,'Error: %s\n',getReport(exception));
    displayer.closeScreen();
    ListenChar();
    ShowCursor();
end