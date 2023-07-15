clc
clear 
close all 
%%Load more than one file
path = 'C:\Users\khorsandi\Desktop\normal\*.txt'
file = dir(path);
for i = 1:length(file)
    xn=[path(1:end-5),file(i,1).name];
    fn=load(xn);
end
%%panjere gozari
z=fn(:,1:8);
%plot(z);
%%filter design
[x,v]=butter(6,[0.3 15]/50,'bandpass');
freqz(x,v);
%%filtering
FF=filter(x,v,z);
plot(FF);
