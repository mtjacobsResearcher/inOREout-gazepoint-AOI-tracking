% Matthew T. Jacobs & Hannah Hart-Pomerantz. 4/19/2019 mtjacobs@ucsc.edu
% This code is for Jenifer Day's Other Race Effect (ORE) study
% It takes raw Gazepoint Data and compresses it to 748 samples (one for
% every sample frame. It will later be used to test whether a face was
% looked at or not


%fileName
% gotta give it Gazepoint "all_gaze) filename: IE MJ_all_gaze.csv

%aveWindow
%When compressing, OREcompress will take aveWindow samples above and below 
% the target sample (one closest to frame) (so a total of aveWindow*2 + 1
% lines)

function compressed = OREcompress(fileName,aveWindow)






%No need to touch anything below here:
%--------------------------------------------------------------------------
m1 = xlsread(fileName, 'D:D'); %time in seconds
m2 = xlsread(fileName, 'L:L'); %BPOGX
m3 = xlsread(fileName, 'M:M'); %BPOGY
m4 = xlsread(fileName, 'N:N'); %validity

m = [m1 m2 m3 m4];


%gathering the number of columns
[row col]  = size(m);


%748 indices (one per frame)
% trims 10 samples off the begining and end of the Gazepoint data
% chooses 748 rows in Gazepoint data to sample from
indices = round(10: row/748 : row -10);

for(i = 1:748)
    startRow = indices(i);
    
    top = startRow - aveWindow;
    bottom = startRow + aveWindow;
    
    toAverage = m(top:bottom ,:);
    compressed(i,:) = mean(toAverage);
    
%     toAverage = m(top:bottom ,:);
%     if length(find(toAverage(:,4)>.8)) == 0
%         compressed(i,:) = [0,0,0,0];
%     else
%         compressed(i,:) = mean(toAverage(find(toAverage(:,4)>.8),:));
%     end
  
    end
end
