function [n] = kNNK(k,testValue,c1train_norm,c2train_norm)
%KNNK Summary of this function goes here
%   Detailed explanation goes here

for j=1:length(c1train_norm)
d(j,:) = [sqrt(abs((testValue(1,1)-c1train_norm(j,1)))^2 + (abs(testValue(1,2)-c1train_norm(j,2))^2)) , 1];
end

for a=1:length(c2train_norm)
d(a+j,:) = [sqrt(abs((testValue(1,1)-c2train_norm(a,1)))^2 + (abs(testValue(1,2)-c2train_norm(a,2))^2)) , 2];
end
% Sorteiren nach der Distanz mit der Angabe der Klasse
dSorted = sortrows(d,1);
% Klassifikatortest für k verschiedene Werte
for m=1:k
dSortedk(m,:) = dSorted(m,:);
end

% Häufigkeit der Klassen zählen
hk1 = sum(ismember(dSortedk,1));
hk2 = sum(ismember(dSortedk,2));

% Nach der Häufigkeit die Klasse zurückgeben
if hk1(1,2) >= hk2(1,2)
    n = 1;
else
    n = 2;
end

end
