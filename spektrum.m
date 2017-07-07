function spektrum(x,npoint,fs) 
%Funktion:  Zeichnen der  FFT des Signals x 
%npoint:    anzahl der punkte; muss eine 2er potenz sein und darf nicht 
%           größer als die länge von x sein. 
%x:         Signalvektor 
%fs:        Abtastfrequenz in Hz              
%y=fft(zeitsignal,n)
load('C:\Users\Arthur VM\Desktop\MuTDI\Daten Teil A\Messung_10V.mat')
y=fft(Strom);
y_betrag=abs(y);
y_betragklein=y_betrag(0,60000);
plot(y_betragklein);
%c = fft(x)/n; 
%amp = 2*abs(c); 
%amp(1) = amp(1)/2; 
%m = floor(npoint/2); 
%title('Amplitudenspektrum') 
xlabel('Frequenz [Hz]') 
ylabel('Amplitude') 
end 