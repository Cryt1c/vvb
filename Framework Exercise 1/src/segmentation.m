function foreground_map = segmentation(frames,FGScribbles,Hfc,Hbc,bins)
%----------------------------------------------------------------------
% Task c: Generate cost-volume
%----------------------------------------------------------------------
%DAVID mit dieser lösung stimmt irgendwas noch nicht ganz, außerdem ist sie noch von dem anderen kopiert ^^
cost = Hfc ./ (Hfc + Hbc);  

    cost(isnan(cost))=0; 
    
    foreground_map = zeros(size(frames,1),size(frames,2),size(frames,4)); 
    f=double(bins)/256.0;
    for i = 1:size(frames,4)    
        
        %extract the 3 color channels
        frameR = double(frames(:,:,1,i));
        frameG = double(frames(:,:,2,i));
        frameB = double(frames(:,:,3,i));
        
        %calculate the colors id for looking up in the histogram
        histIDs=floor(frameR*f) + floor(frameG*f)*bins + floor(frameB*f)*bins*bins+1;
        
        %match every pixel of each frame to foreground(1) or background(0) dependig on the costs.
        foreground_map(:,:,i) = arrayfun(@(id) (cost(id) ), histIDs); 
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
foreground_map = guidedfilter_vid_color(frames, foreground_map, r, rt, eps) * 255;


end
