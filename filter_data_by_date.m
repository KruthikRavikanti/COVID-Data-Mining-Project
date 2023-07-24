function filter_data_by_date(inputFile, outputFile)
    % Check if the input file exists
    if ~isfile(inputFile)
        error('Input file not found. Please provide a valid file path.');
    end
    
    % Read the data from the Excel file using readtable
    tableData = readtable(inputFile);

    % Define the columns to be deleted
    columnsToDelete = [5, 10:18, 20, 22:30, 32:size(tableData, 2)];

    % Delete the specified columns from the table
    tableData(:, columnsToDelete) = [];

    % Convert the date strings to datetime objects
    dates = datetime(tableData{:, 1}, 'InputFormat', 'ddMMMyyyy');
    
    % Define the date range
    startDate = datetime('13-Sep-2020');
    endDate = datetime('22-Nov-2020');

    % Find the indices of dates within the specified range and the specific dates
    validIndices = dates >= startDate & dates <= endDate;
    specificDates = ismember(dates, [datetime('13-Sep-2020'):7:datetime('15-Nov-2020')]);

    % Keep only the rows that correspond to valid indices and specific dates
    filteredData = tableData(validIndices & specificDates, :);
    
    % Sort the filtered data alphabetically by column 2 (state abbreviations)
    sortedData = sortrows(filteredData, 2);

    % Save the sorted data to a new Excel file
    writetable(sortedData, outputFile);
    disp('Filtered, sorted, and columns deleted data saved to "filtered_data.xlsx"');
end



