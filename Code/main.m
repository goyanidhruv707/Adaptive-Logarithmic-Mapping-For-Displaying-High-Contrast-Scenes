%% HDR Image reading and performing adaptive log mapping and then applying gamma correction.
function [imgCor] = main ( bias, gamma, fileName)
HDRImage = hdrread(fileName);
img = adaptiveLogMapping(HDRImage, bias);
hgamma = vision.GammaCorrector(gamma,'Correction','gamma');
imgCor = hgamma(img);
end