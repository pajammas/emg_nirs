%%load data
clear all; close all;
dataEMG1 = importdata('D:\VIBOT\Heriott_Watt\RoboticsProj2\OURDATA\oleksii1measurementGrabSewTap.txt');
win_size = 100;
win_inc = 30;
[start_index, end_index, Num_of_actions] = pre_processing(dataEMG1,27,1200);
training_data = dataEMG1.data;
training_data = training_data(:,2:4);
%%experiment
training_data = training_data(start_index(1):size(training_data,1),:);
start_index = start_index - start_index(1)+1;
end_index = end_index - start_index(1)+1;



training_motion = [ones(1, 13), 2*ones(1 ,10),  3*ones(1 ,14)]';
training_index = start_index';

 testing_data = awgn(training_data, 10);
%extract features
feature_training = extract_feature(training_data,win_size,win_inc);
class_training = getclass(training_data,training_motion,training_index,win_size,win_inc);
% [feature_training,class_training] = remove_transitions(feature_training,class_training);

%%correction of noisy windows
[ feature_training2, class_training2 ] = Window_correction( feature_training, class_training )



% win_inc = 32; % testing data has 87.5% overlap between windows
feature_testing = extract_feature(testing_data,win_size,win_inc);
class_testing = getclass(testing_data,training_motion,training_index,win_size,win_inc);


[error_training,error_testing,classification_training,classification_testing]...
    = ldaclassify(feature_training,feature_testing,class_testing,class_training);


% majority vote smoothing
classification_testing_maj = majority_vote(classification_testing,8,0);
error_testing_maj = sum(classification_testing_maj ~= class_testing)/length(class_testing)*100;

% remove transitions from computation of classification accuracy
[classification_testing_nt,class_testing_nt] = remove_transitions(classification_testing,class_testing);
error_testing_nt = sum(classification_testing_nt ~= class_testing_nt)/length(class_testing_nt)*100;

% majority vote smooth and remove transitions from computation of classification accuracy
[classification_testing_maj_nt,class_testing_nt] = remove_transitions(classification_testing_maj,class_testing);
error_testing_maj_nt = sum(classification_testing_maj_nt ~= class_testing_nt)/length(class_testing_nt)*100;

figure(1)
subplot(1,2,1)
classification_timeplot(class_testing,classification_testing);
title(['Error = ' num2str(error_testing) '%'])
subplot(1,2,2)
classification_timeplot(class_testing,classification_testing_maj);
title(['Majority Vote Error = ' num2str(error_testing_maj) '%'])
% subplot(2,2,3)
%  classification_timeplot(class_testing_nt,classification_testing_nt);
%  title(['No Transitions Error = ' num2str(error_testing_nt) '%'])
% subplot(2,2,4)
%  classification_timeplot(class_testing_nt,classification_testing_maj_nt);
%  title(['Majority Vote/No Transitions Error = ' num2str(error_testing_maj_nt) '%'])

figure(2)
subplot(1,2,1)
confusion_matrix = confmat(class_testing,classification_testing);
%[c,cm,ind,per] = plotconfusion(class_testing,classification_testing);
plotconfmat(confusion_matrix);
title(['Error = ' num2str(error_testing) '%'])
subplot(1,2,2)
confusion_matrix = confmat(class_testing,classification_testing_maj);
plotconfmat(confusion_matrix);
title(['Majority Vote Error = ' num2str(error_testing_maj) '%'])
% subplot(2,2,3)
% confusion_matrix = confmat(class_testing_nt,classification_testing_nt);
% plotconfmat(confusion_matrix);
% title(['No Transitions Error = ' num2str(error_testing_nt) '%'])
% subplot(2,2,4)
% confusion_matrix = confmat(class_testing_nt,classification_testing_maj_nt);
% plotconfmat(confusion_matrix);
% title(['Majority Vote/No Transitions Error = ' num2str(error_testing_maj_nt) '%'])
