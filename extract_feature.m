function feature = extract_feature(data,win_size,win_inc)

if nargin < 3
    if nargin < 2
        win_size = 256;
    end
    win_inc = 32;
end

[Ndata,Nsignal] = size(data);



% Feature Extraction
% getrmsfeat.m root mean square feature
% getmavfeat.m mean absolute value feature
% getiavfeat.m integrated absolute value feature
% getarfeat.m autoregressive feature
% getzcfeat.m zero crossing feature
% getsscfeat.m slope sign change feature
% getwlfeat.m 
feature1 = getrmsfeat(data,win_size,win_inc);
ar_order = 3;
feature2 = getarfeat(data,ar_order,win_size,win_inc);

feature3 = getwlfeat(data,win_size,win_inc);
feature4 = getiavfeat(data,win_size,win_inc);
feature5 = getrmsfeat(data,win_size,win_inc); 
feature = [feature1 feature2 feature3 feature4];
