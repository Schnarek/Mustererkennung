function [ F,fq,yfinal2 ] = FunctionNormAmplspectrum(signal,SamF,NormFrequ)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
y=fft(signal);
ybetrag=abs(y);
l=length(signal)/2;
%Norm Signal to Sampling Frequency
yfinal=ybetrag(1:l)/(SamF);
yfinal2=yfinal;
%2*Amplitude
yfinal2(2:end)=2*yfinal(2:end);
fq= linspace(1,SamF/2,l);
fq = fq/NormFrequ;
%ploting just the half of the fouriertransformation(mirror effect)
%plot(yfinal)
%figure
%ploting the
%plot(fq,yfinal2)
%stem(fq,yfinal2)
%title(name)
%xlabel('Frequency (Hz)')
%ylabel('Amplitude')
[B,F] = max(yfinal2(2:end))
end

