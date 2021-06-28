%% Function to convert from RGB to Yxy
function [ xyzImage ] = convertRGB2Yxy( rgbIMG )

RGB2Yxy = [ 0.5141364, 0.3238786, 0.16036376; ...
            0.265068, 0.67023428, 0.06409157; ...
            0.0241188, 0.1228178, 0.84442666 ];

xyzImage = zeros(size(rgbIMG,1),size(rgbIMG,2), 3);

for y=1:size(rgbIMG,1)
    for x=1:size(rgbIMG,2)
        for c=1:3
            xyzImage(y,x,c) = RGB2Yxy(c,1)*rgbIMG(y,x,1)+RGB2Yxy(c,2)*rgbIMG(y,x,2)+RGB2Yxy(c,3)*rgbIMG(y,x,3);
        end
        
        P = sum(xyzImage(y,x,:));
        if (P > 0)
            t1 =  xyzImage(y,x,1);
            t2 =  xyzImage(y,x,2);
            xyzImage(y,x,1) = xyzImage(y,x,2);
            xyzImage(y,x,2) = t1/double(P);
            xyzImage(y,x,3) = t2/double(P);
        else
            xyzImage(y,x,:) = 0;
        end
    end
end

end

