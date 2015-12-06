function foreground_map = segmentation(frames,FGScribbles,Hfc,Hbc,bins)
%----------------------------------------------------------------------
% Task c: Generate cost-volume
%----------------------------------------------------------------------

% comparison of corresponding frequencies in foreground and background
% histograms, not a number becomes 0 which means color is not in the 
% fore- or background. 0 = background, 1 = foreground
cost = Hfc ./ (Hfc + Hbc);
cost(isnan(cost))=0;

foreground_map = ones(size(frames,1),size(frames,2),size(frames,4));
f=double(bins)/256.0;
for i = 1:size(frames,4)
    
    % precomputing IDs
    frameR = double(frames(:,:,1,i));
    frameG = double(frames(:,:,2,i));
    frameB = double(frames(:,:,3,i));
    IDs=floor(frameR*f) + floor(frameG*f)*bins + floor(frameB*f)*bins*bins+1;
    
    % with anonymus function for every pixel in the IDs-array the costs are
    % checked and stored in the foreground_map
    foreground_map(:,:,i) = arrayfun(@(id) (cost(id) ), IDs);
end

%----------------------------------------------------------------------
% Task e: Filter cost-volume with guided filter
%----------------------------------------------------------------------

r = 5;				% r = filtersize spatially, x and y
rt = 1;				% rt = filtersize temporally, z = time
eps = 0.1;			% eps = regularization parameter for degree of smoothness
threshold = 0.4;	% threshold = parameter for decision if pixel is in the foreground

% perform filter and set pixels over threshold on 1, all others to 0
foreground_map = guidedfilter_vid_color(frames, foreground_map, r, rt, eps)>threshold;

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

% perform filter second time for smooth transitions, multiply with 255 for
% 8-bit color space
foreground_map = uint8(guidedfilter_vid_color(frames, foreground_map, r, rt, eps)*255);
end
