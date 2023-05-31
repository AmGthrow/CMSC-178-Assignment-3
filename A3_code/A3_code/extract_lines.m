function RT = extract_lines(H,rhos,thetas,N)

% H - hough transforms
% rhos - related rho values
% thetas - related theta values
% N - number of peaks to identify
%
% RT - a N rows by 2 columns array of the peak rho and theta values

RT = zeros(N,2);

% -------------------- put your code in below ---------------------------

% NOTES: the peaks appear as elongated reagions of large values in the
% hough data. Simply identifying local maxima may not be enough as the
% central peak is sometimes slightly reduced if the lines are not exactly
% straight. You will also need to make sure you do not pick multiple
% peaks which are associated with the same line estimate.

% The suggested method of approach is to look for a global maxima over a
% region LARGER than a simple 5x5 neighbourhood. This maxima is then
% treated as the strongest line and the rho,theta value recorded. The
% region around this point is then zeroed, and the process repeated for
% the next brightest line. ie.
%

%Determines the size of the region that will be blacked out
%will round up to the next odd number if even
regionSize = 21;

%value that is added and subtracted to the indx to determine the region
regionSize = floor(regionSize/2);

for i=1:N
%    1. find brightest maxima using local neigbourhood estimates (this will 
%        probably require a double for loop etc)

    %find the index of the brightest maxima
    [~, indx] = max(H(:));

    %convert the indx of the brightest maxima  to x and y values
    [x,y] = ind2sub(size(H),indx);
    
%    2. record the rho,theta value
    RT(i,1) = rhos(x);
    RT(i,2) = thetas(y);

%    3. blank out the neighbourhood around the identified maxima
    %recommended area is 5 x 5

    regionXStart = x-regionSize;
    if regionXStart < 1
        regionXStart = 1;
    end
    regionXEnd = x+regionSize;
    if regionXEnd > size(H,1)
        regionXEnd = size(H,1);
    end
    regionYStart = y -regionSize;
    if regionYStart < 1
        regionYStart = 1;
    end
    regionYEnd = y +regionSize;
    if regionYEnd > size(H,2)
        regionYEnd = size(H,2);
    end
    H(regionXStart:regionXEnd,regionYStart:regionYEnd) = 0;
    %H(x-regionSize:x+regionSize,y-regionSize:y+regionSize) = 0;
end
%
% dummy code - return N random estimates - NOTE: remove the two lines below
% RT(:,1) = rhos( max(1,round(length(rhos)*rand(1,N))))';
% RT(:,2) = thetas( max(1,round(length(thetas)*rand(1,N))) )';

% ---------------------put your code in above ---------------------------

figure;

imagesc(thetas,rhos,H); %axis equal tight;
colormap(gray);
title('Hough Transform - Detected Maximas');
xlabel('Theta');
ylabel('Rho');
hold on;
plot(RT(:,2),RT(:,1),'bo');
hold off;
drawnow;

return

% -----------
% END OF FILE
