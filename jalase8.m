clc
clear
close all;

path = 'C:\Users\khorsandi\Documents\project with Matlab\najafabadian\jalase8\total_dataset\*.jpg';
Files = dir(path);
% length(Files)
for i = 1:length(Files);
    fn = [path(1:end-5) Files(i,1).name];
    im = imread(fn);
    im1=rgb2gray(im);
    im2=histeq(im1);
    im3=medfilt2(im2,[5,5]);

    sigma = 0.4; %sigma characterizes the amplitude of edges
    alpha = 0.5; %alpha controls smoothing of details
    im4 = locallapfilt(im3, sigma,alpha);

    im5=im2double(im4);
    f1=mean(im5(:));
    f2=var(im5(:));
    f3=std(im5(:));
    f4=mean(pburg(im5(:), 4));
    f5=entropy(im5(:));
    f6=kurtosis(im5(:));
    f7=skewness(im5(:));
    feature(i, :) = [f1 f2 f3 f4 f5 f6 f7]; 

end

output=[ones(100,1);zeros(100,1)];


x = feature';
t = output';

% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. Suitable in low memory situations.
trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.

% Create a Pattern Recognition Network
hiddenLayerSize = 3;
net = patternnet(hiddenLayerSize, trainFcn);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 80/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 5/100;

% Train the Network
[net,tr] = train(net,x,t);

% Test the Network
y = net(x);
e = gsubtract(t,y);
performance = perform(net,t,y)
tind = vec2ind(t);
yind = vec2ind(y);
percentErrors = sum(tind ~= yind)/numel(tind);

% View the Network
view(net);

% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, ploterrhist(e)
figure, plotconfusion(t,y);
%figure, plotroc(t,y)

%figure()
%imhist(im1)
%title('histogram Cancer image before histogram equalization')
%figure()
%imshow(im1)
%title('histogram Cancer image before histogram equalization')



%figure()
%imhist(im2)
%title('histogram Cancer image after histogram equalization')
%figure()
%imshow(im2)
%title('histogram Cancer image after histogram equalization')

%figure()
%imshow(im3)
%title('Normal image after apply median filter')

%figure()
%imshow(im4)
%title('Normal image after apply laplacian filter')

% imshow(im)
% title('Normal image')