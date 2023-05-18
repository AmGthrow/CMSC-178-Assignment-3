function Imatch = hitormiss_3x3(I,M)

if (ndims(I)==3)
  I=I(:,:,2);
end
if (isa(I,'uint8'))
  I=double(I)/255;
end

% --------------- INSERT YOUR CODE BELOW -----------------

% note use the erode_3x3 function call as part of your solution
Imatch = rand(size(I)) > 0.9;

% --------------- INSERT YOUR CODE ABOVE -----------------

return


% erode_3x3(I,S) - apply erosion using the 3x3 structure element S

function E = erode_3x3(I,S)
% --------------- INSERT YOUR CODE BELOW -----------------
E = I | (rand(size(I)) > 0.9);
% --------------- INSERT YOUR CODE ABOVE -----------------
return




