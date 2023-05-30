function [E,F,G] = log_edge(I,N)

% inputs : I - image, N - size of filter 
% outputs: E - edge image, F - filter

if (nargin<2)
  N=5;
end

% force I to be a NxN real number array, and create the laplacian
% of gaussians filter. Note that F sums to zero has has total
% energy = 1.
I=double(I(:,:,1));
if (N<=3)
  F=[0 1 0; 1 -4 1; 0 1 0]/8;
else
  % NOTE: if you do not have the image proc toolbox with MATLAB you
  % may need to modify this section of code. if so then please let me know.
  F = fspecial('log',N,floor((N-1)/3)/2);
end

% TO PREVENT THE THRESHOLD GOING TOO LOW FOR SMALL FILTER SIZES
% 3,5,7,9 etc USE THE FOLLOWING SCALE FACTOR IN YOUR THRESHOLD
% CALCULATION. 
threshK=max(1,-0.5*N+7.5); % multiply threshold by this factor

%-----------change code from here --------------------------------
%
% 1. Create and empty array E and and an array G containing the filtered
%    image (use conv2 with the 'same' option to do this).
E = zeros(size(I));
G = conv2(I, F, 'same');

% 2. compute threshold t (0.75*mean(G)) of the LoG image stored in
%    G (and multiply by threshK)
t = 0.75 * mean(abs(G(:))) * threshK;

% 3. identify the zero crossing points 
% 4. preserve those zero crossing points where the sum of the
%    magnitudes of G accross the zero crossing is > t

% Get half of the distance from the center based on the size of the filter 
halfDist = floor(N/2);

% Create array so that checking each side will be easier
sides = [0 1; 0 -1; 1 0; -1 0];
[rowSide, ~] = size(sides);

% Iterate through image, except on edges. 
[y,x] = size(G);
for i = halfDist:y-halfDist
    for j = halfDist:x-halfDist
        
        % Check if current pixel is positive
        currPixel = G(i,j);
        if currPixel > 0
             
            % If positive, check if one side is negative. If so, a zero
            % crossing is present and is indicated in the edge image.
            for k = 1:rowSide
                edge = G(i + sides(k,1),j + sides(k,2));
                if edge < 0
                    if abs(currPixel) + abs(edge) > t
                        E(i,j) = 1;
                        break
                    end
                end
            end     
        end
    end
end

%-----------change code above here --------------------------------

return
