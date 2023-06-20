% This function calculate the maximum hourly solar radiation

function [Radiation] = HourlyExtra(month,day,hour)

n = NumberOfDays(month,day);

fi = 44.55;  % Latitude
Ll = 11.44;  % Longitude
Ls= 15;      % Standard meridian for the local time zone
Isc = 1367;  % Solar constant

delta = 23.45 * sind((360*((284+n)/365)));  % Declination
ws = acosd(-tand(fi)*tand(delta));          % Sunset hour angle
N = (2/15)*ws;                              % Number of daylight hours

LT2 = hour*60;
LT1 = (hour-1)*60;
B = (n-1)*360/365;
E = 229.2*(0.000075 + (0.001868*cosd((B)))-(0.032077*sind((B)))-(0.014615*cosd((2*B)))-(0.04089*sind((2*B))));

ST1 = (4*(Ls-Ll)+E+LT1)/60;
ST2 = (4*(Ls-Ll)+E+LT2)/60;
w2 = 15*(ST2-12);  % Hour angle
w1 = 15*(ST1-12);

Eo = 1+(0.033*(cosd(((360*n)/365))));
AA = (12*3600*Isc)/pi;
BB = cosd(fi)*cosd(delta)*(sind(w2)-sind(w1));
CC = (pi*(w2-w1)*sind(fi)*(sind(delta))/180);
Io = AA * Eo * (BB + CC)*0.000277 ; 

if Io>0
    Radiation = Io;
else
    Radiation = 0;
end
end

