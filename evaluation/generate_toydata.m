numPx = 100;

mask = rand(numPx,numPx) > 0.5;

maskIn = mask;
while 1
    maskOut = bwmorph(maskIn,"majority");

    if any(maskIn(:)-maskOut(:))
        maskIn = maskOut;
    else
        break
    end %if
end
imwrite(maskOut,'E:\Publish\Lipid_Binary_Phase_Segmentizer\toydata_binary_mask.tif')

%convolve with gaussian
img = imgaussfilt(double(maskOut),2);
figure; imagesc(img); colormap("gray")

imwrite(img,'E:\Publish\Lipid_Binary_Phase_Segmentizer\toydata_blurred.tif')
