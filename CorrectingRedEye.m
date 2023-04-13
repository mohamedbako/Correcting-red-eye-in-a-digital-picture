
% ------ Start Face Definition ------

A1 = imread('redB.jpg');
[row, col] = size(A1);
 
% Creating a object
faceRecognition = vision.CascadeObjectDetector();
 
faceDefinition = step(faceRecognition, A1);
 
% ------ Face Definition End ------
 
% converted A1 image RGB to HSV
A2 = rgb2hsv(A1);

% output A2
imwrite(A2,'Rgb2Hsv.jpg');

% Put size of the picture
row = size(A2)*[1;0;1];
col = size(A2)*[0;1;0];
 
% H => (:,:,1) ve S => (:,:,2) 
A3 = uint8(255*A2(:,:,1));
A3 = uint8(255*A2(:,:,2));
 
% output A3
imwrite(A3,'HS_Photo.jpg');
 
% ------ Start Padding ------
 
row = size(A3)*[1;0];
col = size(A3)*[0;1];
 
for i=1:row
for j=1:col
 B(i+1,j+1)=A3(i,j); %A matrix moves to the center of B matrix
    if i==1
    B(1,j+1)=A3(1,j ); 
    end
    
    if i==row
    B(row+2,j+1)=A3(row,j );
    end
    
    if j==1
    B(i+1,1 )=A3(i,1 ); 
    end
    
    if j==col
    B(i+1,col+2 )=A3(i,col); 
    end
end
end
B(1,1 )=A3(1,1 );
B(row+2,1 )=A3(row,1 );
B(1,col+2 )=A3(1,col );
B(row+2,col+2 )=A3(row,col );
 
% ------ Padding End ------
 
 
% this loop [col*row] look at pixels one by one
% if (A) the pixel value is above the threshold 
% Let A3 matrix be 0 
% get another 1
 
esik = 100;
A4 = 0;
for i = 1 : row
  for j = 1 : col
    if B(i,j) > esik 
      A4(i,j) = 0;
    else 
      A4(i,j) = 1;
    end
  end
end
 
% output A4
imwrite(A4,'WhiteBlack.jpg');
 
% Specified the face area
% R => (:,:,1), G => (:,:,2), B => (:,:,3)
X = double(A1);
 for i = faceDefinition (1,2) : faceDefinition (1,2) + faceDefinition (1,3) 
    for j =  faceDefinition (1,1) : faceDefinition (1,1) + faceDefinition (1,4) 
    X(i,j,1) = A4(i,j).*X(i,j,1);
    X(i,j,2) = A4(i,j).*X(i,j,2);
    X(i,j,3) = A4(i,j).*X(i,j,3);
    end
 end
B = uint8(X);
 
% output B
imwrite(B,'Last_Picture.jpg');

