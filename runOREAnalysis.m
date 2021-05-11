% Matthew T. Jacobs. 4/19/2019 mtjacobs@ucsc.edu
% Script written for Jennifer Day's Other Race Effect Study (ORE)
% This script runs the analysis of data

%name of Gaze-point data file: (e.g. mj_all_gaze.csv)
fileName = "---"; % Edit here

%how much do you want to reduce the circles or increase them
buffer = -50; % Edit here (default -50 reduces oval diameter by 50 pixels)

%how many rows above and below do you want to compress the Gazepoint data
%(ie 3 would compress a total of (3*2 +1) samples of data)
aveWindow = 3; % Edit here (default 3 means 7 lines compressed)


%data = [frame number, boolean face or not, %valid]
data = inOREout(fileName, buffer, aveWindow);
