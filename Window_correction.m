function [ feature_training2, class_training2 ] = Window_correction( feature_training, class_training )

RMS3channel = feature_training(:,1)+feature_training(:,2)+feature_training(:,3);

% Construct blurring window.
% windowWidth = int16(10);
% gaussFilter = gausswin(10);
% gaussFilter = gaussFilter / sum(gaussFilter); % Normalize.
% % Do the blur.
% smoothedVector = conv(RMS3channel, gaussFilter);
indices2discard  = find(RMS3channel < 200);

feature_training(indices2discard,:) = [];
class_training(indices2discard) = [];
% figure(); hold on;
% plot(RMS3channel);
% g = 130*ones(size(RMS3channel));
% plot(g);

feature_training2 = feature_training;
class_training2 = class_training;
end

