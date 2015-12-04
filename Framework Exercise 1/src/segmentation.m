function foreground_map = segmentation(frames,FGScribbles,Hfc,Hbc,bins)
%----------------------------------------------------------------------
% Task c: Generate cost-volume
%----------------------------------------------------------------------
foreground_map = ones(size(frames,1),size(frames,2), frames(4));
f=double(bins)/256.0;

for i = 1:size(frames,4)
	imr=double(frames(:,:,1));
	img=double(frames(:,:,2));
	imb=double(frames(:,:,3));
	
	%keinen plan warum das so nicht funktioniert, in der loesung anderer ansatz
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
end

%----------------------------------------------------------------------
% Task e: Filter cost-volume with guided filter
%----------------------------------------------------------------------
r = 5;				% r = filtersize spatially, x and y
rt = 1;				% rt = filtersize temporally, z = time
eps = 0.1;			% eps = regularization parameter for degree of smoothness	
threshold = 0.5;	% threshold = parameter for decision if pixel is in the foreground

foreground_map = guidedfilter_vid_color(frames, foreground_map, r, rt, eps);
foreground_map(foreground_map>threshold)=1;
%----------------------------------------------------------------------
% Task f: delete regions which are not connected to foreground scribble
%----------------------------------------------------------------------
% every frame is checked so that only connected regions remain in the foreground_map
for i = 1:size(foreground_map,3)
    foreground_map(:,:,i) = keepConnected(foreground_map(:,:,i), FGScribbles);
end
%----------------------------------------------------------------------
% Task g: Guided feathering
%----------------------------------------------------------------------
foreground_map=[];


end
