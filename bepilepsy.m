clc
clear all
close all
path = 'C:\Users\khorsandi\OneDrive\اسناد\project with Matlab\najafabadian\Jalase 14\O\*.txt';
Files = dir(path);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Fs = 174;  % Sampling Frequency

Fstop1 = 3;     % First Stopband Frequency
Fpass1 = 4;     % First Passband Frequency
Fpass2 = 70;    % Second Passband Frequency
Fstop2 = 71;    % Second Stopband Frequency
Dstop1 = 0.01;  % First Stopband Attenuation
Dpass  = 0.1;   % Passband Ripple
Dstop2 = 0.01;  % Second Stopband Attenuation
dens   = 20;    % Density Factor

% Calculate the order from the parameters using FIRPMORD.
[N, Fo, Ao, W] = firpmord([Fstop1 Fpass1 Fpass2 Fstop2]/(Fs/2), [0 1 ...
                          0], [Dstop1 Dpass Dstop2]);

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, Fo, Ao, W, {dens});
Hd = dfilt.dffir(b);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%filter design for alpha band extraction

Fs = 174;  % Sampling Frequency

Fstop1 = 7;     % First Stopband Frequency
Fpass1 = 8;     % First Passband Frequency
Fpass2 = 13;    % Second Passband Frequency
Fstop2 = 14;    % Second Stopband Frequency
Dstop1 = 0.01;  % First Stopband Attenuation
Dpass  = 0.1;   % Passband Ripple
Dstop2 = 0.01;  % Second Stopband Attenuation
dens   = 20;    % Density Factor

% Calculate the order from the parameters using FIRPMORD.
[N, Fo, Ao, W] = firpmord([Fstop1 Fpass1 Fpass2 Fstop2]/(Fs/2), [0 1 ...
                          0], [Dstop1 Dpass Dstop2]);

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, Fo, Ao, W, {dens});
Hd1 = dfilt.dffir(b);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%filter design for betha band extraction

Fs = 174;  % Sampling Frequency

Fstop1 = 12;     % First Stopband Frequency
Fpass1 = 13;     % First Passband Frequency
Fpass2 = 25;    % Second Passband Frequency
Fstop2 = 26;    % Second Stopband Frequency
Dstop1 = 0.01;  % First Stopband Attenuation
Dpass  = 0.1;   % Passband Ripple
Dstop2 = 0.01;  % Second Stopband Attenuation
dens   = 20;    % Density Factor

% Calculate the order from the parameters using FIRPMORD.
[N, Fo, Ao, W] = firpmord([Fstop1 Fpass1 Fpass2 Fstop2]/(Fs/2), [0 1 ...
                          0], [Dstop1 Dpass Dstop2]);

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, Fo, Ao, W, {dens});
Hd2 = dfilt.dffir(b);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%filter design for Gama band extraction

Fs = 174;  % Sampling Frequency

Fstop1 = 24;     % First Stopband Frequency
Fpass1 = 25;     % First Passband Frequency
Fpass2 = 64;    % Second Passband Frequency
Fstop2 = 65;    % Second Stopband Frequency
Dstop1 = 0.01;  % First Stopband Attenuation
Dpass  = 0.1;   % Passband Ripple
Dstop2 = 0.01;  % Second Stopband Attenuation
dens   = 20;    % Density Factor

% Calculate the order from the parameters using FIRPMORD.
[N, Fo, Ao, W] = firpmord([Fstop1 Fpass1 Fpass2 Fstop2]/(Fs/2), [0 1 ...
                          0], [Dstop1 Dpass Dstop2]);

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, Fo, Ao, W, {dens});
Hd3 = dfilt.dffir(b);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%filter barqh shahr
w=50/(174/2);
bw=w;
[num,den] = iirnotch(w,bw); %notch filter implementation


for i=1:length(Files)
    fn = [path(1:end-5) Files(i,1).name];
    x=load(fn);
    xden=filter(Hd,x);
    xden=filter(num,den,xden);

    alpha=filter(Hd1,xden)
    betha=filter(Hd2,xden)
    Gama=filter(Hd3,xden)

    f1 = FMD( alpha )
    f2 = FMD( betha )
    f3 = FMD( Gama )

    f4 = FMN( alpha )
    f5 = FMN( betha )
    f6 = FMN( Gama )

    f7 = FR( alpha )
    f8 = FR( betha )
    f9 = FR( Gama )

    f10 = WL( alpha )
    f11 = WL( betha )
    f12 = WL( Gama )

    feature_normal(i,:)=[f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12]


   
end    




path = 'C:\Users\khorsandi\OneDrive\اسناد\project with Matlab\najafabadian\Jalase 14\S\*.txt';
Files = dir(path);


for i=1:length(Files)
    fn = [path(1:end-5) Files(i,1).name];
    x=load(fn);
    xden=filter(Hd,x);

    alpha=filter(Hd1,xden)
    betha=filter(Hd2,xden)
    Gama=filter(Hd3,xden)

    f1 = FMD( alpha )
    f2 = FMD( betha )
    f3 = FMD( Gama )

    f4 = FMN( alpha )
    f5 = FMN( betha )
    f6 = FMN( Gama )

    f7 = FR( alpha )
    f8 = FR( betha )
    f9 = FR( Gama )

    f10 = WL( alpha )
    f11 = WL( betha )
    f12 = WL( Gama )

    feature_abnormal(i,:)=[f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12];
    
end 

input = [feature_normal;feature_abnormal]
output = [zeros(100,1);ones(100,1)]
mix=[input,output]; %matrix 200 dar 2
