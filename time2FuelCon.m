function [ FuelConTime ] = time2FuelCon( TimeString )
%FUELCONTIMECONVERTER Converts a string in the format HH:MM:SS:FFF to the FuelCon time format
%   Here an example:
%   00:00:10:000 to PT0H0M10.000S

    TimeStringVector = sscanf(TimeString, '%d:%d:%f:%f');
    FuelConTime = ['PT' num2str(TimeStringVector(1)) 'H' num2str(TimeStringVector(2)) 'M' num2str(TimeStringVector(3)) '.' num2str(TimeStringVector(4),'%03d') 'S'];
end

