% This function estimate uncertainty solar radiation using historical data
% and Monte Carlo, and based on sky cloudiness

function [rad] = Radiation(month,day,hour,beta,totalV,tableV)
fi = 44.55;    % Latitude
Ll = 11.44;    % Longitude
Ls= 15;        % Standard meridian for the local time zone
Isc = 1367;    % Solar constant
n = NumberOfDays(month,day);
delta = 23.45 * sind((360*((284+n)/365)));  % Declination
LT = hour*60;
B = (n-1)*360/365;
E = 229.2*(0.000075 + (0.001868*cosd((B)))-(0.032077*sind((B)))-(0.014615*cosd((2*B)))-(0.04089*sind((2*B))));
ST = (4*(Ls-Ll)+E+LT)/60;
w = 15*(ST-12);  % Hour angle
r = 0.28;

data = totalV;   % Cloudiness of sky
table = tableV;  % Table of all types of sky condition
        [hs,he]=Bright(month,day);
        Ig = Global(month,day,hour);
        if Ig<=0
            rad = 0;
        else
            type = WT(data);
            total = table{1,hour-4};
            if (hour==5 || hour==19) && type==5
                V = 0.9;
            else
                switch type
                    case 1
                        inV = total(:,1);
                        inV(inV==0) = [];
                    case 2
                        inV = total(:,2);
                        inV(inV==0) = [];
                    case 3
                        inV = total(:,3);
                        inV(inV==0) = [];
                    case 4
                        inV = total(:,4);
                        inV(inV==0) = [];
                    case 5
                        inV = total(:,5);
                        inV(inV==0) = [];
                end

                [param,~] = wblfit(inV);
                C = param(1);
                K = param(2);
                V = wblinv(rand,C,K);
            end
            I = (1-V)*Ig;
            kt = I/HourlyExtra(month,day,hour);
            if kt<=0.22
                Id = I*(1-(0.09*kt));
            elseif kt>0.22 && kt<=0.8
                Id = I*(0.9511-(0.1604*kt)+(4.388*(kt^2))-(16.638*(kt^3))+(12.336*(kt^4)));
            elseif kt>0.8
                Id = I * 0.165;
            end
            Ib = I - Id;
            
            tetaz = acosd((cosd(fi)*cosd(delta)*cosd(w))+(sind(fi)*sind(delta)));
            qadr = acosd(((cosd(tetaz)*sind(fi))-sind(delta))/(sind(tetaz)*cosd(fi)));
            gamas = sign(w)*abs(qadr);
            if (fi-delta)>0
                gama=0;
            end
            if (fi-delta)<=0
                gama=180;
            end
            teta = acosd((cosd(tetaz)*cosd(beta))+(sind(tetaz)*sind(beta)*cosd(gamas-gama)));
            
            Rb = cosd(teta)/cosd(tetaz);
            termb = Ib * Rb;
            termd = Id*((1+cosd(beta))/2);
            termr = I*r*((1-cosd(beta))/2);
            Ibeta = termb + termd + termr;
            rad = Ibeta;
        end
end
