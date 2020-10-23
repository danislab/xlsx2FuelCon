function xlsx2FuelCon
%xlsx2Fuelcon convertes .xlsx spreadsheets to .xml sequences for Evaluator
% B battery test benches from FuelCon.


% Import xlsx file
% select a xlsx file from the file system with the selection dialog box
[file,path] = uigetfile(fullfile(pwd,'Sequences','*.xlsx'),'select file');
selectedfile = fullfile(path, file);
% define the file name for the xml output file
xmlfile = strrep(selectedfile,'.xlsx','.xml');

% read the selected xlsx file
[~, ~, data] = xlsread(selectedfile);
% get size of the table
[row, col] = size(data);

% remove 'NaNs' from data
data(cellfun(@(data) any(isnan(data)),data)) = {''};


% Check the table for errors
% Check if ProgramStepNumber is increasing and correct them if it is not
% the case
ProgramStepNumbers = cell2mat(data(2:end,1));
if min(diff(ProgramStepNumbers)) < 1
   disp('Wrong ProgramStepNumber');
   disp('Correct ProgramStepNumber automatically');
   data(2:end,1) = num2cell(1:1:length(ProgramStepNumbers));
end


% Prepare the table for the xml file
% loop trough rows
for r=1:row-1
    % loop trough columns
    for c=1:col
        % correct time with FuelCon time format
        if strfind(data{1,c}, 'Time') > 0
            if isempty(num2str(data{r+1,c}))
                data{r+1,c} = 'PT0S';
            else
                data{r+1,c} = time2FuelCon(data{r+1,c});
            end
        % convert TagValues to strings
        elseif strfind(data{1,c}, 'TagValue') > 0
            if isempty(num2str(data{r+1,c}))
                data{r+1,c} = 0;
            else
                data{r+1,c} = data{r+1,c};
            end
        % convert JumpCycles to strings
        elseif strfind(data{1,c}, 'JumpCycles') > 0
            if isempty(num2str(data{r+1,c}))
                data{r+1,c} = 0;
            else
                data{r+1,c} = data{r+1,c};
            end  
        end
    end
end


% Create a xml document
docNode = com.mathworks.xml.XMLUtils.createDocument('SequencerSchema');


% Create SequencerTestProgramStep
% loop trough rows
for r=1:row-1
    % crate row node
    row_node = docNode.createElement('SequencerTestProgramStep');
    docNode.getDocumentElement.appendChild(row_node);
    
    % loop trough rows
    for c=1:col
        % append columns to node
        name_node = docNode.createElement(data{1,c});
        name_text = docNode.createTextNode(num2str(data{r+1,c}));
        name_node.appendChild(name_text);
        row_node.appendChild(name_node);
    end
end


% Save xml document
% read header lines from template
header = fileread('header.xml');

% get body from docNode
body = xmlwrite(docNode);
% remove wrong header lines from body
body = body(61:end);

% merge correct header with body
xmltext = [header body];

% store xml file
fid = fopen(xmlfile,'w');
if fid == -1
    error('Cannot open file: %s', xmlfile);
else
    fprintf(fid,'%s',xmltext);
    fclose(fid);
end


end
