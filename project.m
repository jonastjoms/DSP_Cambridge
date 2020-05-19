clear all
close all
clc

% Define target device parameters:
% Display resolution i 640x480, 60 fremes per second
% Toral resolution, 800 x 525 pixels
fps = 60;
x = 800;
y = 525;
% Pixel clock: nominally 25.175 MHz +/- 0.5%
fp = 25.175e6;
% Find horizontal frequency by dividing with number of pixels per line
fh = fp/x;
% Find vertical frequency by dividing fh with number of lines
fv = fh/y;
% Define sampling parameters & centre frequency
% Sampling frequency
fs = 64e6;
% Centre frequency
fc = 425e6;

% Load recordings
filename_signal = 'scene3-640x480-60-425M-64M-40M.dat';
file1 = fopen(filename_signal, 'r', 'ieee-le');
iq = fread(file1, [fs, 2], 'single=>single');
iq = complex(iq(:,1), iq(:,2))';
%iq = iq(1:(fs*0.02)); % Don't keep all frames
fclose(file1);

% Match pixelrate by downsamlping from fs to fp:
t = linspace(1,fs,fp);
downsampled = interp1(1:length(iq), iq, t);

% Now Amplitude demodulate the signal:
s = abs(downsampled);

% Construct matrix of image:
im = zeros(y,x);
n = 100;
for i = 1:y
    for j = 1:x
        im(i,j) = s(n);
        n = n+1;
    end
end
image(im)

        
    



