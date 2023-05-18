function Imatch = hitormiss_3x3(I,M)

if (ndims(I)==3)
  I=I(:,:,2);
end
if (isa(I,'uint8'))
  I=double(I)/255;
end

% --------------- INSERT YOUR CODE BELOW -----------------

B1 = M == 1; % Get set pixels
B2 = M == -1; % Get unset pixels
Imatch = erode_3x3(I, B1) & erode_3x3(~I, B2);

% --------------- INSERT YOUR CODE ABOVE -----------------

return


% erode_3x3(I,S) - apply erosion using the 3x3 structure element S

function E = erode_3x3(I,S)
% --------------- INSERT YOUR CODE BELOW -----------------

[HEIGHT, WIDTH] = size(I);
E = zeros(HEIGHT, WIDTH);
for y=2:HEIGHT-1 % Avoid borders of image, assume S is 3x3
    for x=2:WIDTH-1
        top = y-1;
        bottom = y+1;
        left = x-1;
        right = x+1;
        Isubset = I(top:bottom, left:right);
        match = Isubset & S;        

        E(y,x) = isequal(match, S); % Ensure all values in filter are present in image
    end
end


% --------------- INSERT YOUR CODE ABOVE -----------------
return




