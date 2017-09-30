function ColorSim = ColorSimimarity(noFrameImgLab, pixelList, bins)
spnum = size(pixelList, 1);
spHist = zeros(spnum, bins * 3);

for i = 1:spnum
    
    L = noFrameImgLab(:,:,1);
    A = noFrameImgLab(:,:,2);
    B = noFrameImgLab(:,:,3);
    varL = L(pixelList{i});
    varA = A(pixelList{i});
    varB = B(pixelList{i});
   
    binL = Calbin(varL,bins);
    binA = Calbin(varA,bins);
    binB = Calbin(varB,bins);
    
    spHist(i,:) = [hist(binL,0:bins-1)/length(pixelList{i}),hist(binA,0:bins-1)/length(pixelList{i}),hist(binB,0:bins-1)/length(pixelList{i})] / 3; 
   
end


ColorSim = squareform(pdist(spHist,@distfun));
ColorSim(1: spnum + 1 : end) = 1;

end
        
