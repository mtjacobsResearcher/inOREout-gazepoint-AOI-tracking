% Matthew T. Jacobs. 4/19/2019 mtjacobs@ucsc.edu
% This code is for Jenifer Day's Other Race Effect (ORE) study
% It is a modification of demo code from Psychtoolbox
% This program iterates through photos and allows oval AOE's to be drawn and recorded. 
%In this particular study, it was to record the faces in a video of Skyrim gameplay. 



% Clear the workspace and the screen
sca;
close all;
clearvars;

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers
screens = Screen('Screens');

% Draw to the external screen if avaliable
screenNumber = max(screens);

% Define black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% Open an on screen window
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);


% Setup the text type for the window
Screen('TextFont', window, 'Ariel');
Screen('TextSize', window, 50);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);


% Set the mouse to the top left of the screen to start with
SetMouse(0, 0, window);

% Draw the rect to the screen
%Screen('FillOval', window, rectColor, centeredRect, maxDiameter);

% The avaliable keys to press
escapeKey = KbName('ESCAPE');
upKey = KbName('UpArrow');
downKey = KbName('DownArrow');
leftKey = KbName('LeftArrow');
rightKey = KbName('RightArrow');
space = KbName('space');


%pull all the images
a = dir('Enter pathway here'); %edit here

%setting up size variables for oval
height= 200;

length= 200;

%way to exit the program
exitDemo = false;

%Store all of the coordinates in stuff
stuff = [];
i=1;
howMuchStuff = size(stuff);

%Array to save things
%CHANGE NUMBERS HERE TO CHANGE WHICH FRAMES ARE LOOKED AT
for j=1:10
%stuff(i,:) = ["height" "length" "x" "y"]; 

    ima=imread(['images/Whiterun (' num2str(j) ')'], 'jpg');
    
 % now visible on screen


% Loop the animation until escape is pressed
    while exitDemo==false
        Screen('PutImage', window, ima); % put image on screen
    %Screen('Flip',window);
     % Check the keyboard to see if a button has been pressed
        [keyIsDown,secs, keyCode] = KbCheck;

    
    % Get the current position of the mouse
        [x, y, buttons] = GetMouse(window);
    
    % Depending on the button press, either move ths position of the square
    % or exit the demo
        if keyCode(escapeKey)
            pause(.5);
            exitDemo = true;
            
        elseif keyCode(leftKey) && length>150
            length = length - 5;
            height = height -5;
        elseif keyCode(rightKey)
            length = length + 5;
            height = height +5; 
        elseif keyCode(space)
            %slide height length xcoord ycoord
            pause(.5);
            stuff(i,:) = [j height length x y];
            i = 1+i;
            howMuchStuff = size(stuff);
        end

   
    % We clamp the values at the maximum values of the screen in X and Y
    % incase people have two monitors connected. This is all we want to
    % show for this basic demo.
    x = min(x, screenXpixels);
    y = min(y, screenYpixels);

    % Construct our text string
    textString = ['Mouse X: ' num2str(round(x))...
        ' Mouse Y: ' num2str(round(y)) ' on frame: ' num2str(j) 'space: ' num2str(howMuchStuff(1))];

    % Text output of mouse position draw in the centre of the screen
    DrawFormattedText(window, textString, 'center', 'center', white);
    
    %makes the circle
    makeOval(window,length, height, x ,y);
    

    
    % Flip to the screen
    Screen('Flip', window);

    end
    
    fprintf('%d\n\n\n\n\n\n',i);
    locations = unique(stuff, 'rows');
    exitDemo=false;
    

end

% Clear the screen
sca;