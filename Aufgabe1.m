%% Teil A

for i=1:6
load(['Daten Teil A\Messung_',num2str(i),'0V.mat'])
fs = 40000;
% Fs Samplefrequency
Y = fft(Strom);
y_betrag = abs(Y);
l = length(Strom)/2;
f = y_betrag(1:l)/(fs);
f2 = f;
f2(2:end) = 2*f(2:end); 

fq = linspace(1,(fs/2),l);
% Limit spectrum
%fq=fq/8;
% Norm Vekt to Frequency
%y_betrag(1,1)=0;
figure(1)
hold on;
plot(fq,f);
%stem(f,y_betrag);
%Messung = sprintf('Plot with  %d0 Volt',i);
title(Messung)
xlabel('Frequenz [Hz]'); 
ylabel('|Y(f)|'); 
grid on;
end

for x=1:6
load(['Daten Teil A\Messung_',num2str(x),'0V.mat'])
Drehzahl(x,:) = Erkennung(Tacho,x,Fs);
Drehzahl_Umin = Drehzahl*60;
end

%% Teil B
load('Daten Teil B\kNN.mat');

figure(3);
title('C1 und C2 Train')
xlabel('Merkmal 1'); 
ylabel('Merkmal 2');
hold on;
plot(c2train(:,1),c2train(:,2),'.b');
plot(c1train(:,1),c1train(:,2),'.r');
[c1test_norm,c2test_norm,c1train_norm,c2train_norm] = min_max_norm( c1test,c2test,c1train,c2train);

figure(4);
title('C1 und C2 Train Normiert')
xlabel('Merkmal 1'); 
ylabel('Merkmal 2');
hold on;
plot(c2train_norm(:,1),c2train_norm(:,2),'.b');
plot(c1train_norm(:,1),c1train_norm(:,2),'.r');

figure(5);
title('C1 und C2 Test Normiert')
xlabel('Merkmal 1'); 
ylabel('Merkmal 2');
hold on;
plot(c2test_norm(:,1),c2test_norm(:,2),'.b');
plot(c1test_norm(:,1),c1test_norm(:,2),'.r');

% Implementierung kNN KLassifikator
%k = 7;
% Spaltenvektor ertsellen mit der Klassenzuordnung
for k=3:20
% Test Klasse 1
for ic1=1:length(c1test_norm)
  nc1 = kNNK(k,c1test_norm(ic1,1:2),c1train_norm,c2train_norm); 
  ksc1(ic1,:) = [nc1];
end

% Test KLasse 2
for ic2=1:length(c2test_norm)
  nc2 = kNNK(k,c2test_norm(ic2,1:2),c1train_norm,c2train_norm); 
  ksc2(ic2,:) = [nc2];
end

x = sum(ismember(ksc1,1));
y = sum(ismember(ksc2,2));

Prozent(k,:) = (x+y)/600 * 100
k
end
%% 2. Statistische Grundlagen
load('Daten Teil B\gauss.mat');
% Calc and visualising
Berechnungcov(r_c1(:,1),r_c1(:,2));
Berechnungcov(r_c2(:,1),r_c2(:,2));

hold on
%% Workspace Test-functions
% Enter dimension
p = 2;
%calc mean of x y
sum_x = sum(r_c1(:,1));
mw_x = sum_x/length(r_c1);

sum_y = sum(r_c1(:,2));
mw_y = sum_y/length(r_c1);

% Covarianz AA (Varianz)
 cov_AA = sum((r_c1(:,1) - mw_x) .* (r_c1(:,1) -  mw_x)/(length(r_c1)-1));
% Covarianz AB
 cov_AB = sum((r_c1(:,1) - mw_x) .* (r_c1(:,2) -  mw_y)/(length(r_c1)-1));
% Covarianz BA
 cov_BA = sum((r_c1(:,2) - mw_y) .* (r_c1(:,1) - mw_x) /(length(r_c1)-1));
% Covarianz BB
 cov_BB = sum((r_c1(:,2) - mw_y) .* (r_c1(:,2) -  mw_y)/(length(r_c1)-1));
 
 cov_MA = [ cov_AA,cov_AB;cov_BA,cov_BB];

 % 3 Dimensionale Darstellung
mu = [mw_x mw_y];
Sigma = [cov_AA cov_AB; cov_BA cov_BB];
x1 =  -3:.2:8.5 ; x2 = -3:.2:8.5;
%x1 = linspace(0,r_c1(:,1),3); x2 = linspace(0,r_c1(:,2),3);
%x1 = -3:.2:3; x2 = -3:.2:3;
%[X1,X2] = meshgrid(r_c1(:,1),r_c1(:,2));
[X1,X2] = meshgrid(x1,x2);
F = mvnpdf([X1(:) X2(:)],mu,Sigma);
%F = reshape(F,length(r_c1(:,2)),length(r_c1(:,1)));
F = reshape(F,length(x2),length(x1));
%surf(r_c1(:,1),r_c1(:,2),F);
surf(x1,x2,F);
caxis([min(F(:))-.5*range(F(:)),max(F(:))]);
axis([-3 8 -3 8 0 .4])
xlabel('x1'); ylabel('x2'); zlim([0 inf]); zlabel('Probability Density');

% 2 Dimensionale Darstellung
rng default  % For reproducibility
r = mvnrnd(mu,Sigma,100);
figure
title('Bivariate Normalverteilung')
xlabel('X1'); 
ylabel('X2');
hold on;
plot(r(:,1),r(:,2),'+')

sF = 40000;

Drehzahl = Erkennung(Tacho,sF);

% Luftschall
%[F,F_x,F_s3] = FunctionNormAmplspectrum(ConvertedData.Data.MeasuredData(3).Data,sF,Drehzahl);
% Stromsignal
[F,F_x,F_s4] = FunctionNormAmplspectrum(Strom,sF,Drehzahl);
stem(F_x,F_s4,'r')

