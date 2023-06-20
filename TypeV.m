% This function calculate the sky condition and select its type using
% historical data


function [WT,Main] = TypeV()

[~, sheets] = xlsfinfo('Hourly.xlsx');  % Read the historical data 
Days = [31,28,31,30,31,30,31,31,30,31,30,31];

hourly = cell(1,12);

for m=1:12
    hourly{1,m} = xlsread('Hourly.xlsx',sheets{m});
end

cv = cell(1,12);

for ii=1:12
    rad = hourly{1,ii};
    dt = zeros(24,Days(ii));
    for jj=1:Days(ii)
        for kk=1:24
            if (Global(ii,jj,kk)>0)
                dt(kk,jj) = (Global(ii,jj,kk)-rad(kk,jj))/Global(ii,jj,kk);
            end
        end
    end
    cv{1,ii} = dt;
end

B = zeros(24,31);
C = zeros(24,31);
for n=1:12
    A = cv{1,n};
    C = [A B];
    B = C;
end

fin = zeros(366,1);
HR = cell(1,15);
count = 1;
for j=5:19
    fin = B(j,:);
    fin(fin==0) = [];
    HR{1,j-4}=fin;
    
end

cc=0;
all = zeros(5490,1);
BB = zeros(1,366);
CC = zeros(1,366);
for nn=1:15
    AA = HR{1,nn};
    CC = [BB AA];
    BB = CC;
end
    BB(BB==0) = [];
    TWT = BB;
 
Vout = cell(1,15);
for o=1:15
    res = zeros(365,5);
c1=1;
c2=1;
c3=1;
c4=1;
c5=1;
    for p=1:length(HR{1,o})
        data = HR{1,o};
        if data(1,p)<0
            data(1,p) = 0.01;
        end
        if data(1,p)>10
            data(1,p) = 0.95;
        end 
        
        if (data(1,p)>=0 && (data(1,p)<0.3))
            res(c1,1)=data(1,p);
            c1=c1+1;
            continue;
        end
                
        if (data(1,p)>=0.3 && (data(1,p)<0.6))
            res(c2,2)=data(1,p);
            c2=c2+1;
            continue;
        end
            
        if (data(1,p)>=0.6 && (data(1,p)<0.8))
            res(c3,3)=data(1,p);
            c3=c3+1;
            continue;
        end    
        
        if (data(1,p)>=0.8 && (data(1,p)<0.9))
            res(c4,4)=data(1,p);
            c4=c4+1;
            continue;
        end    
        
        if (data(1,p)>=0.9 && (data(1,p)<1))
            res(c5,5)=data(1,p);
            c5=c5+1;
            continue;
        end
    end
    Vout{1,o} = res;
end
WT = TWT;
Main = Vout;
end
