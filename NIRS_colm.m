clear all; close all
win_size = 32;
win_inc = 32;
%dataEMG1 = importdata('D:\VIBOT\Heriott_Watt\RoboticsProj2\colm\colm_training_emg.txt');
dataEMG1 = importdata('D:\VIBOT\Heriott_Watt\RoboticsProj2\oleksii\nirs_ole_from_yogesh.txt');
datEMGORIG = importdata('D:\VIBOT\Heriott_Watt\RoboticsProj2\OURDATA\nirs_ole.txt');
g = 9;

subplot(3,1,1)
plot(dataEMG1(:,1)); hold on
plot(dataEMG1(:,2)); 

subplot(3,1,2)
plot(dataEMG1(:,3)); hold on
plot(dataEMG1(:,4)); 

subplot(3,1,3)
plot(dataEMG1(:,5)); hold on
plot(dataEMG1(:,6)); 

figure(); plot(dataEMG1(:,5)+dataEMG1(:,6))




% [start_index, end_index, Num_of_actions] = pre_processing(dataEMG1,27,1200);
% training_data = dataEMG1.data;
% training_data = training_data(:,2:4);
% %%experiment
% training_data = training_data(start_index(1):size(training_data,1),:);
% start_index = start_index - start_index(1)+1;
% end_index = end_index - start_index(1)+1;
% %training_motion = [ones(1, 10), 2*ones(1 ,10),  3*ones(1 ,10)]';
% training_motion = [ones(1, 13), 2*ones(1 ,10),  3*ones(1 ,13)]';
% 
% 
% training_index = start_index';
% 
% %load the test dataset
%    % dataEMG2 = importdata('D:\VIBOT\Heriott_Watt\RoboticsProj2\colm\colmtestshort.txt');
%      dataEMG2 = importdata('D:\VIBOT\Heriott_Watt\RoboticsProj2\oleksii\oleksii_testing.txt');
% %      dataEMG2.data(:,2:4) =  dataEMG2.data(:,3:5);
% %      save('oleksii_testing.txt','dataEMG2')
%     [start_index_test, end_index_test, Num_of_actions_test] = pre_processing(dataEMG2,27,1200)
%     testing_data = dataEMG2.data;
%     testing_data = testing_data(:,2:4);
%     %%experiment
%     testing_data = testing_data(start_index_test(1):size(testing_data,1),:);
%     start_index_test = start_index_test - start_index_test(1)+1;
%     start_index_test = start_index_test';
%     end_index_test = end_index_test - start_index_test(1)+1;
%     testing_motion = [1 1 1 1 1 2 2 2 2 3 3 3 3 3 3]';
% 
% % testing_data = awgn(training_data, 10);
% %extract features
% feature_training = extract_feature(training_data,win_size,win_inc);
% class_training = getclass(training_data,training_motion,training_index,win_size,win_inc);
% % [feature_training,class_training] = remove_transitions(feature_training,class_training);
% 
% % win_inc = 32; % testing data has 87.5% overlap between windows
% feature_testing = extract_feature(testing_data,win_size,win_inc);
% class_testing = getclass(testing_data,testing_motion,start_index_test,win_size,win_inc);
% 
% 
% [error_training,error_testing,classification_training,classification_testing]...
%     = ldaclassify(feature_training,feature_testing,class_training,class_testing);
% 
% 
% % majority vote smoothing
% classification_testing_maj = majority_vote(classification_testing,3,0);
% error_testing_maj = sum(classification_testing_maj ~= class_testing)/length(class_testing)*100;
% 
% % remove transitions from computation of classification accuracy
% [classification_testing_nt,class_testing_nt] = remove_transitions(classification_testing,class_testing);
% error_testing_nt = sum(classification_testing_nt ~= class_testing_nt)/length(class_testing_nt)*100;
% 
% % majority vote smooth and remove transitions from computation of classification accuracy
% [classification_testing_maj_nt,class_testing_nt] = remove_transitions(classification_testing_maj,class_testing);
% error_testing_maj_nt = sum(classification_testing_maj_nt ~= class_testing_nt)/length(class_testing_nt)*100;
% 
% figure(1)
% subplot(2,2,1)
% classification_timeplot(class_testing,classification_testing);
% title(['Error = ' num2str(error_testing) '%'])
% subplot(2,2,2)
% classification_timeplot(class_testing,classification_testing_maj);
% title(['Majority Vote Error = ' num2str(error_testing_maj) '%'])
% subplot(2,2,3)
%  classification_timeplot(class_testing_nt,classification_testing_nt);
%  title(['No Transitions Error = ' num2str(error_testing_nt) '%'])
% subplot(2,2,4)
%  classification_timeplot(class_testing_nt,classification_testing_maj_nt);
%  title(['Majority Vote/No Transitions Error = ' num2str(error_testing_maj_nt) '%'])
% 
% figure(2)
% subplot(2,2,1)
% confusion_matrix = confmat(class_testing,classification_testing);
% plotconfmat(confusion_matrix);
% title(['Error = ' num2str(error_testing) '%'])
% subplot(2,2,2)
% confusion_matrix = confmat(class_testing,classification_testing_maj);
% plotconfmat(confusion_matrix);
% title(['Majority Vote Error = ' num2str(error_testing_maj) '%'])
% subplot(2,2,3)
% confusion_matrix = confmat(class_testing_nt,classification_testing_nt);
% plotconfmat(confusion_matrix);
% title(['No Transitions Error = ' num2str(error_testing_nt) '%'])
% subplot(2,2,4)
% confusion_matrix = confmat(class_testing_nt,classification_testing_maj_nt);
% plotconfmat(confusion_matrix);
% title(['Majority Vote/No Transitions Error = ' num2str(error_testing_maj_nt) '%'])
% 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% dataEMG2 = importdata('D:\VIBOT\Heriott_Watt\RoboticsProj2\colm\dataEMG2.txt');
% [start_index, end_index, Num_of_actions] = pre_processing(dataEMG2,27,1200)