function [c1test_norm,c2test_norm,c1train_norm,c2train_norm] = min_max_norm( c1test,c2test,c1train,c2train)
%MIN_MAX_NORM Summary of this function goes here
%   Detailed explanation goes here

% Min Klasse 1 Brechnung
minc1x = min(c1train(:,1));
minc1y = min(c1train(:,2));
% min Klasse 2
minc2x = min(c2train(:,1));
minc2y = min(c2train(:,2));
% Max Klasse 1 Berechnung
maxc1x = max(c1train(:,1));
maxc1y = max(c1train(:,2));
% Max Klasse 2
maxc2x = max(c2train(:,1));
maxc2y = max(c2train(:,2));
% Absolutes minimum der 2 Klassen
minAbsolutX = min([minc1x minc2x]);
minAbsolutY = min([minc1y minc2y]);

maxAbsolutX = max([maxc1x maxc2x]);
maxAbsolutY = max([maxc1y maxc2y]);
% Testdaten
c1test_norm(:,1) = (c1test(:,1) - minAbsolutX)/(maxAbsolutX - minAbsolutX);
c1test_norm(:,2) = (c1test(:,2) - minAbsolutY)/(maxAbsolutY - minAbsolutY);

c2test_norm(:,1) = (c2test(:,1) - minAbsolutX)/(maxAbsolutX - minAbsolutX);
c2test_norm(:,2) = (c2test(:,2) - minAbsolutY)/(maxAbsolutY - minAbsolutY);

% Traindaten
c1train_norm(:,1) = (c1train(:,1) - minAbsolutX)/(maxAbsolutX - minAbsolutX);
c1train_norm(:,2) = (c1train(:,2) - minAbsolutY)/(maxAbsolutY - minAbsolutY);

c2train_norm(:,1) = (c2train(:,1) - minAbsolutX)/(maxAbsolutX - minAbsolutX);
c2train_norm(:,2) = (c2train(:,2) - minAbsolutY)/(maxAbsolutY - minAbsolutY);
end

