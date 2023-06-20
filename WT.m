% This function calculate the Weibull distribution of solar radiation
% Here we calculate the PDF and CDF of solar radiation

function [GuessedType] = WT(data)
data = sort(data);
for i=1:length(data)
    if data(i)<0
        data(i) = 0.01;
    end
    if data(i)>1
        data(i) = 0.95;
    end
end
[param,hat] = wblfit(data);
C = param(1);
K = param(2);
V_type = wblinv(rand,C,K);

    if V_type<0
        V_type = 0.01;
    end

    if V_type>1
        V_type = 0.95;
    end


    if V_type<0.3
        type = 1;
    end
    if V_type>=0.3 && V_type<0.6
        type = 2;
    end
    if V_type>=0.6 && V_type<0.8
        type = 3;
    end
    if V_type>=0.8 && V_type<0.9
        type = 4;
    end
    if V_type>=0.9 && V_type<1    
        type = 5;
    end

GuessedType = type;
end

