function [ output ] = adaptiveLogMapping ( I, bias )
%The LD_MAX value which is assumed to be 100
ldmax = 100;
b = bias;
gamma = 1;
expoFactor = 1; %Exposure factor (optional). I assumed it as 1.

output = zeros(size(I,1),size(I,2),size(I,3));

N = size(I,1)*size(I,2);
del = .0001;
% Converting to xyz Image to take Y component into consideration.(as mentioned in paper)
xyzImg = convertRGB2Yxy(I);

% The world adaption luminance
worldAdaptionLuminance = exp((1/N)*(sum(sum(log(xyzImg(:,:,1) + del)))));
worldAdaptionLuminance = worldAdaptionLuminance / ((1+b-.85) ^ 5);

L_wmax = max(max(xyzImg(:,:,1)));
L_wmax = expoFactor * L_wmax / worldAdaptionLuminance;

%Starting of the execution for each pixel.
tic;
for y = 1:size(output,1)
    for x = 1:size(output,2)
        L_w = expoFactor * (xyzImg(y,x,1)^gamma) / worldAdaptionLuminance;
        
        %Calculation of left part in the equation of Ld
        leftNumerator = ldmax * .01;
        leftDenominator = log10(L_wmax + 1);
        leftPart = double(leftNumerator) / double(leftDenominator);
        
        %Calculation of the right part
        rightNumerator = log(L_w + 1);
        rightexp = log(b) / log(.5);
        rightIn = L_w / L_wmax;
        rightDenominator = log(2 + (( rightIn ^ rightexp ) * 8));
        rightPart = double(rightNumerator) / double(rightDenominator);
        
        %Calculation of Ld
        lD = leftPart * rightPart;
        xyzImg(y,x,1) = lD;
    end
end
toc;
%Converting the output back to RGB Image
output = convertYxy2RGB(xyzImg);
end