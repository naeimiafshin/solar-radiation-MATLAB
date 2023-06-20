% This function calculate the global solar radiation

function [GR] = Global(month,day,hour)
Io = HourlyExtra(month,day,hour);
n = NumberOfDays(month,day);
fi = 44.55;    % Latitude
Ll = 11.44;    % Longitude
Ls= 15;        % Standard meridian for the local time zone
Isc = 1367;    % Solar constant
delta = 23.45 * sind((360*((284+n)/365)));  % Declination

LT = hour*60;
B = (n-1)*360/365;
E = 229.2*(0.000075 + (0.001868*cosd((B)))-(0.032077*sind((B)))-(0.014615*cosd((2*B)))-(0.04089*sind((2*B))));
ST = (4*(Ls-Ll)+E+LT)/60;
w = 15*(ST-12);     % Hour angle
r = 0.28;

alpha = asind((sind(fi)*sind(delta))+(cosd(fi)*(cosd(delta)*cosd(w))));
Beta = 0;
if (fi-delta)>0
    az=0;
end
if (fi-delta)<=0
    az=180;
end
cosi = sind(delta)*((sind(fi)*cosd(Beta))-(cosd(fi)*sind(Beta)*cosd(az)))+...
    (cosd(delta)*cosd(w)*((cosd(fi)*cosd(Beta))+(sind(fi)*sind(Beta)*cosd(az))))+...
    (cosd(delta)*sind(Beta)*sind(w));

M = ((1229+((614*sind(alpha))^2))^0.5)-(614*sind(alpha));
tadir = 0.56*(exp(-0.65*M)+exp(-0.095*M));
tadif = 0.271-(0.294*tadir);
taref = 0.271+(0.706*tadir);
Idir = Io * tadir ;
Idif = Io * tadif * sind(alpha);

Ig = Idir + Idif;  
GR = Ig;
end


