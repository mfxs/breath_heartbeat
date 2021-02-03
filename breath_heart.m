function [rate_breath,rate_heart,y_breath,y_heart]=breath_heart(L,T0)
% y_breath=wden(L,'heursure','s','mln',5,'haar');
% y_breath=smooth(y_breath,70);
Fs=100;                                                % Sampling Frequency
N=32;                                                  % Order
Fc1=0.1;                                               % First Cutoff Frequency
Fc2=1;                                                 % Second Cutoff Frequency
flag='scale';                                          % Sampling Flag
win=hamming(N+1);                                      % Create the window vector for the design algorithm.
b=fir1(N,[Fc1 Fc2]/(Fs/2),'bandpass',win,flag);        % Calculate the coefficients using the FIR1 function.
y_breath=filtfilt(b,1,L);
y_breath=smooth(y_breath,70);
subplot(311);
plot(T0,L);
subplot(312);
plot(T0,y_breath);
[~,locs_breath]=findpeaks(y_breath,'MinPeakDistance',100);
i=1;
threshold1=20000;
while i<=length(locs_breath)
    flag=0;
    a=locs_breath(i)-100;
    b=locs_breath(i)+100;
    if a<1
        a=1;
    end
    if b>length(y_breath)
        b=length(y_breath);
    end
    if (y_breath(locs_breath(i))~=max(y_breath(a:b)))
        flag=1;
    end
    if i==1
        c=1;
        if y_breath(locs_breath(i))-min(y_breath(c:locs_breath(i)))<threshold1
            flag=1;
        end
    else
        c=locs_breath(i-1);
        if (y_breath(locs_breath(i))-min(y_breath(c:locs_breath(i)))<threshold1)&&(y_breath(locs_breath(i))<y_breath(c))
            flag=1;
        end
    end
    if i==length(locs_breath)
        d=length(y_breath);
        if y_breath(locs_breath(i))-min(y_breath(locs_breath(i):d))<threshold1
            flag=1;
        end
    else
        d=locs_breath(i+1);
        if (y_breath(locs_breath(i))-min(y_breath(locs_breath(i):d))<threshold1)&&(y_breath(locs_breath(i))<y_breath(d))
            flag=1;
        end
    end
    if flag==1
        locs_breath(i)=[];
    else
        i=i+1;
    end
end
hold on;
scatter(T0(locs_breath),y_breath(locs_breath));
rate_breath=60000/((T0(locs_breath(end))-T0(locs_breath(1)))/(length(locs_breath)-1));
% % % % % 
% % % % % 
% % % % % 
% % % % % 
Fs=100;                                                % Sampling Frequency
N=32;                                                  % Order
Fc1=0.7;                                               % First Cutoff Frequency
Fc2=2.5;                                               % Second Cutoff Frequency
flag='scale';                                          % Sampling Flag
win=hamming(N+1);                                      % Create the window vector for the design algorithm.
b=fir1(N,[Fc1 Fc2]/(Fs/2),'bandpass',win,flag);        % Calculate the coefficients using the FIR1 function.
y_heart=filtfilt(b,1,L-y_breath);
subplot(313);
plot(T0,y_heart);
[~,locs_heart]=findpeaks(y_heart,'MinPeakDistance',40);
i=1;
threshold2=15000;
while i<=length(locs_heart)
    flag=0;
    a=locs_heart(i)-40;
    b=locs_heart(i)+40;
    if a<1
        a=1;
    end
    if b>length(y_heart)
        b=length(y_heart);
    end
    if (y_heart(locs_heart(i))~=max(y_heart(a:b)))
        flag=1;
    end
    if i==1
        c=1;
        if y_heart(locs_heart(i))-min(y_heart(c:locs_heart(i)))<threshold2
            flag=1;
        end
    else
        c=locs_heart(i-1);
        if (y_heart(locs_heart(i))-min(y_heart(c:locs_heart(i)))<threshold2)&&(y_heart(locs_heart(i))<y_heart(c))
            flag=1;
        end
    end
    if i==length(locs_heart)
        d=length(y_heart);
        if y_heart(locs_heart(i))-min(y_heart(locs_heart(i):d))<threshold2
            flag=1;
        end
    else
        d=locs_heart(i+1);
        if (y_heart(locs_heart(i))-min(y_heart(locs_heart(i):d))<threshold2)&&(y_heart(locs_heart(i))<y_heart(d))
            flag=1;
        end
    end
    if flag==1
        locs_heart(i)=[];
    else
        i=i+1;
    end
end
hold on;
scatter(T0(locs_heart),y_heart(locs_heart));
rate_heart=60000/((T0(locs_heart(end))-T0(locs_heart(1)))/(length(locs_heart)-1));

% figure(2)
% plot(T0,y_heart);
% hold on
% scatter(T0(locs_heart),y_heart(locs_heart));
% scatter([4.57 4.57]*10^7,[-1.5*10^5 -1.5*10^5+threshold2]);
end