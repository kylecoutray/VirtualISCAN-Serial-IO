% setup the serial communication
serialPort = 'COM3'; % specify your COM port
baudRate = 115200; % set baud rate (115200 to mimic ISCAN)
serialObj = serial(serialPort, 'BaudRate', baudRate, 'Terminator', 'LF');

%output file names
outputFileName = 'calculated_positions.txt';
dataReportFileName = 'data_report.txt';

try
    %open the serial port
    fopen(serialObj);

    disp(['Serial port ', serialPort, ' opened.']);
    fileID2 = fopen(dataReportFileName, 'w');
    %open the datareport file

    % open the output file for overwriting
    disp('Reading data... Press Ctrl+C to stop.');
    while true
        %if there is data available to read
        if serialObj.BytesAvailable > 0
            %read a line of data
            rawData = fgetl(serialObj);
            
            %every update write new line to report
            fprintf(fileID2, rawData);
            fprintf(fileID2, "\n");
            
            %also print data for easier visualization
            %and to ensure successful communication
            disp([rawData]);
            
            %parsing
            parsedValues = sscanf(rawData, '%d %f %f %f %f %f');
            
            %ensure correct number of values are parsed
            if length(parsedValues) == 6

                %extract all relevant values
                sample = parsedValues(1);
                pupil_h1 = parsedValues(2);
                pupil_v1 = parsedValues(3);
                p_cr_h1 = parsedValues(5);
                p_cr_v1 = parsedValues(6);
                
                % calculate X and Y positions\
                % typically they'll take pupil location 
                % and subtract the corneal reflection

                x_position = (pupil_h1 - p_cr_h1);
                y_position = (pupil_v1 - p_cr_v1);

               %{ 
                we will tune these positions to "normalize" it
                for our unity size.
                these are using values off the data sheet. 
                taking what "should" be the center...

                242-(-2.8) ~ 244.8 = X pos
                136-(-28.5) ~ 164.5 = Y pos

                So... adjusted positions will be edited by this
                much in order to have it around the "center

                we will also apply a "weight" to it.
                    The max delta is 4. Since our screen
                 is 1920x1080, we will scale our position
                to a value that stays within the camera comfortably
               %}

                scale = 50; %tuneable scale
                x_position = (x_position - 244.8)*2*scale;
                y_position = (y_position - 164.5)*scale;
                
                %overwrite the results to the position file
                %we only want most current data
                fileID = fopen(outputFileName, 'w');
                fprintf(fileID, '%.2f,%.2f\n', x_position, y_position);

                %comma and no spaces formatting only
                fclose(fileID);
                
              
                
            end
        end
    end
catch ME

    %error handling - display error and close resources
    disp('Error occurred:');
    disp(ME.message);
    
end

%cleanup
fclose(serialObj);
delete(serialObj);
disp('Serial port closed.');
