function Drehzahl = Erkennung(Tacho,Fs)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Lt = length(Tacho);
NFFTt = 2^nextpow2(Lt);
% Limiting Spectrum
Yt = fft(Tacho,NFFTt)/2;
% Norm Vect to Frequency
ft = Fs/2*linspace(0,1,NFFTt/2+1);
yt_betrag = abs(Yt(1:NFFTt/2+1));
% Get max Vect No.
[a,b] = max(yt_betrag);
% Norm Vect t
x_norm = length(Yt)/Fs;
x_nb = b/x_norm;
Drehzahl = x_nb/8
yt_betrag(1,1) = 0;
figure(1)
plot(ft,yt_betrag);
end

