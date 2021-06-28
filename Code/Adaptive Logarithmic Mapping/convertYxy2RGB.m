%% Function to convert from xyz to RGB
function [ rgbImg ] = convertYxy2RGB( yxyIMG )

epsilonValue = 0.00001;

Yxy2RGB = [ 2.5651, -1.1665, -0.3986; ...
		   -1.0217, 1.9777, 0.0439; ...
		    0.0753, -0.2543, 1.1892 ];

rgbImg = zeros(size(yxyIMG,1),size(yxyIMG,2), 3);


for y=1:size(yxyIMG,1)
    for x=1:size(yxyIMG,2)
        Y = yxyIMG(y,x,1);
        if ((Y > epsilonValue) && (yxyIMG(y,x,2) > epsilonValue) && (yxyIMG(y,x,3) > epsilonValue))
            X = (yxyIMG(y,x,2)*Y) / yxyIMG(y,x,3);
            Z = (X/yxyIMG(y,x,2)) - X - Y;
        else
            X = epsilonValue;
            Z = epsilonValue;
        end
        
        for c=1:3
            rgbImg(y,x,c) = Yxy2RGB(c,1)*X + Yxy2RGB(c,2)*Y+Yxy2RGB(c,3)*Z;
        end
    end
end
              
end

