%making a mock spatial working memory task

%setting up psychtoolbox
Screen('Preference', 'SkipSyncTests', 1);
PsychDefaultSetup(2);

%open a window and set parameters
screenNumber = max(Screen('Screens'));
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, [0, 0, 0]);
[xCenter, yCenter] = RectCenter(windowRect);
fixationSize = 10; %set fixation point size
boxSize = 100; %set box size
boxOffset = 300; %offset from the center

%there are 8 total positions for the box to appear
angles = 0:45:315; %degrees for 8 positions

positions = [cosd(angles); sind(angles)]' * boxOffset;
positions = positions + [xCenter, yCenter];

%arbitrary timing parameters
timeFixation = 0.5; %fix. point length
timeBoxFlash = 0.5; %box length
timeISI = 1; %delay period

%5 cycles then stop
numCycles = 5;

for cycle = 1:numCycles
    % show fixation point
    Screen('FillOval', window, [255, 255, 255], [xCenter - fixationSize, yCenter - fixationSize, xCenter + fixationSize, yCenter + fixationSize]);
    Screen('Flip', window);
    WaitSecs(timeFixation);

    %randomly select a position for the first box
    idx1 = randi(8);
    pos1 = positions(idx1, :);

    %flash the first box
    Screen('FillRect', window, [255, 255, 255], [pos1(1) - boxSize / 2, pos1(2) - boxSize / 2, pos1(1) + boxSize / 2, pos1(2) + boxSize / 2]);
    Screen('Flip', window);
    WaitSecs(timeBoxFlash);

    %delay period
    % are stimulus-selective neurons firing!?!?!?!

    Screen('FillOval', window, [255, 255, 255], [xCenter - fixationSize, yCenter - fixationSize, xCenter + fixationSize, yCenter + fixationSize]);
    Screen('Flip', window);
    WaitSecs(timeISI);

    %determine if same possion
    isSamePosition = randi(2) == 1;
    if isSamePosition
        pos2 = pos1;

    else
        idx2 = mod(idx1 + 4 - 1, 8) + 1; %opposite position
        pos2 = positions(idx2, :);
    end

    %flash the second box
    Screen('FillRect', window, [255, 255, 255], [pos2(1) - boxSize / 2, pos2(2) - boxSize / 2, pos2(1) + boxSize / 2, pos2(2) + boxSize / 2]);
    Screen('Flip', window);
    WaitSecs(timeBoxFlash);

    %delay period
    Screen('FillOval', window, [255, 255, 255], [xCenter - fixationSize, yCenter - fixationSize, xCenter + fixationSize, yCenter + fixationSize]);
    Screen('Flip', window);
    WaitSecs(timeISI);
end

%done
sca;