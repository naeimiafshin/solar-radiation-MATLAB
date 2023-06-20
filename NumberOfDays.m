% This finction calculate the number of days of the year

function [DayNumber] = NumberOfDays(month,day)

Days = [31,28,31,30,31,30,31,31,30,31,30,31];

if month == 1
    output = day;
end

count = 0;
if month ~= 1
    for i=1:month-1
        count = count + Days(i);
    end
    output = count + day;
end

DayNumber = output;
end

