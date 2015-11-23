function foreground_map = segmentation(frames,FGScribbles,Hfc,Hbc,bins)
%----------------------------------------------------------------------
% Task c: Generate cost-volume
%----------------------------------------------------------------------
cost = ones(size(frames,1),size(frames,2));


f=double(bins)/256.0;
imr=double(frames(:,:,1));%*255+1;
img=double(frames(:,:,2));%*255+1;
imb=double(frames(:,:,3));%*255+1;
for k = 1:size(frames,2)
    for l = 1:size(frames,1)
        IDs=floor(imr(l,k)*f) + floor(img(l,k)*f)*bins + floor(imb(l,k)*f)*bins*bins+1;
        if ((Hfc(IDs) + Hbc(IDs)) ~= 0)
            cost(l,k) = Hfc(IDs) / ((Hfc(IDs) + Hbc(IDs)));
        else
            cost(l,k) = 0;
        end
    end    
end

%----------------------------------------------------------------------
% Task e: Filter cost-volume with guided filter
%----------------------------------------------------------------------


%----------------------------------------------------------------------
% Task f: delete regions which are not connected to foreground scribble
%----------------------------------------------------------------------


%----------------------------------------------------------------------
% Task g: Guided feathering
%----------------------------------------------------------------------
foreground_map=[];


end
