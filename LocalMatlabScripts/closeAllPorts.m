if ~isempty(instrfind)
    fclose(instrfind); %close any open serial connections
    delete(instrfind); %delete the serial objects
    clear instrfind;   %clear from MATLAB workspace
end
