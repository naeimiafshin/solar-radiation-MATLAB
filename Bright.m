% This function calculate sunrise and sunset

function [hour_start,hour_end] = Bright(month,day)

n = NumberOfDays(month,day);
% 
fi = 44.55;  % Latitude
Ll = 11.44;  % Longitude
Ls= 15;      % Standard meridian for the local time zone
Isc = 1367;  % Solar constant

delta = 23.45 * sind((360*((284+n)/365)));  % Declination
ws = acosd(-tand(fi)*tand(delta));          % Sunset hour angle
N = (2/15)*ws;                              % Number of daylight hours
sunrise = 12 - (N/2);
sunrise = ceil(sunrise);
sunset = 12 + (N/2);
sunset = floor(sunset);
hour_start = sunrise;
hour_end = sunset;
end