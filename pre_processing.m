
function [start_index, end_index, Num_of_actions] = pre_processing(dataEMG1,AmpThreshold,TimeThreshold)
%clear all; close all;
%dataEMG1 = importdata('D:\VIBOT\Heriott_Watt\RoboticsProj2\OURDATA\oleksii1measurementGrabSewTap.txt');

%the input to the function is a data file obtained from EMG equippment`
dataEMG = dataEMG1.data;
dataEMG = dataEMG(:,2:4);

Signal_avrage  = dataEMG(:,1) + dataEMG(:,2) + dataEMG(:,3);
Channel1 = dataEMG(:,1);
Channel2 = dataEMG(:,2);
Channel3 = dataEMG(:,3);
Fs = 12100;
Fn = Fs/2;
Ts = 1/Fs;
T  = [0:length(Signal_avrage)-1]*Ts;
Wp = [950 1000]/Fn;
Ws = [0.5 1/0.5].*Wp;
Rp =  1;
Rs = 30;
[n,Wn] = buttord(Wp, Ws, Rp, Rs);
[b, a] = butter(n, Wn);
[sos, g] = tf2sos(b, a);
S1F = filtfilt(sos, g, Signal_avrage);
SGS1 = sgolayfilt(abs(S1F), 1, 901);

TrueSignal = zeros(size(SGS1,1),1);
%AmpThreshold = 27;
H = SGS1 > AmpThreshold;
TrueSignal(H) = 1;
H = H.*SGS1;
 
% 
 A = TrueSignal';

v = A; %// data
w = [false v~=0 false]; %// "close" v with zeros, and transform to logical
starts = find(w(2:end) & ~w(1:end-1)); %// find starts of runs of non-zeros
ends = find(~w(2:end) & w(1:end-1))-1; %// find ends of runs of non-zeros
%result = arrayfun(@(s,e) v(s:e), starts, ends, 'uniformout', false); %// build result
diff = ends - starts;
%TimeThreshold = 1200;
starts(diff < TimeThreshold) = [];
ends(diff < TimeThreshold) = [];

%%filter a double action

for i= 1:size(starts,2) -1
    corr(i) = ends(i) - starts(i+1); 
end
tt =  corr(corr>-1000);
if ~isempty(tt)
    indexR = find(corr==tt);
    ends(indexR) = [];
    starts(indexR+1) = [];
end

start_index = starts;
end_index = ends;
Num_of_actions = size(starts,2);
%plotiing some results
% figure();
%     plot(T(10000:30000), Signal_avrage(10000:30000),'Color','[0 0.3 0.9]'); hold on
%     plot(T, SGS1,'Color','[0.8 0.3 0.8]' ); 
% 
% 
%     grid on
%     for j=1:size(starts,2)
%         plot(T(starts(j):ends(j)), Signal_avrage(starts(j):ends(j)), 'Color','r');
%         
%     end
%     hold off;
% 
% figure();
%     subplot(3,1,1);
%     plot(T, Channel1,'Color','[0 0.3 0.9]'); hold on
%     grid
%     for j=1:size(starts,2)
%         %plot(T(starts(j):ends(j)), Channel1(starts(j):ends(j)), 'Color','r');
%         title('R.BRACHIORAD(uV) signal')
%     end
%     hold off;
%     
%     subplot(3,1,2);
%     plot(T, Channel2,'Color','[0 0.3 0.9]'); hold on
%     grid
%     for j=1:size(starts,2)
%         %plot(T(starts(j):ends(j)), Channel2(starts(j):ends(j)), 'Color','r');
%         title('R.FLEX.CARP.R(uV)');
%     end
%     hold off;
%     
%     subplot(3,1,3);
%     plot(T, Channel3,'Color','[0 0.3 0.9]'); hold on
%     grid
%     for j=1:size(starts,2)
%        % plot(T(starts(j):ends(j)), Channel3(starts(j):ends(j)), 'Color','r');
%         title('R.FLEX.CAPR.U(uV)');
%     end
%     hold off;
    
end
