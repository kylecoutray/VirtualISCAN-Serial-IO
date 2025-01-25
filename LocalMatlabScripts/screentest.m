%ensurepsychtoolbox is functional
Screen('Preference', 'SkipSyncTests', 1); % Skips synchronization tests (useful for quick testing)

%regular white
[window, windowRect] = Screen('OpenWindow', max(Screen('Screens')), [255 255 255]);

%display a message to confirm the screen is working
Screen('TextSize', window, 30); %set text size
DrawFormattedText(window, 'Screen Test Successful!', 'center', 'center', [0 0 0]); % Black text
Screen('Flip', window); %flip to show the text

%pause for 3 seconds to observe the screen
WaitSecs(3);

%close the screen
Screen('CloseAll');
