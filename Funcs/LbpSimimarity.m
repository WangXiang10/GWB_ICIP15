function LbpSim = LbpSimimarity(imglbp, pixelList, bins)
imglbp = mynormalize(imglbp, 0, 255);
spnum = size(pixelList, 1);
spHist = zeros(spnum, bins);
for i = 1: spnum
    L = imglbp;
    varL = L(pixelList{i});
    binL = Calbin(varL,bins);
    spHist(i,:) = hist(binL,0:bins-1)/length(pixelList{i});
end

LbpSim = squareform(pdist(spHist,@distfun));
LbpSim(1: spnum + 1 : end) = 1;
end
        
