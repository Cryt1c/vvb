%xpos, ypos: position for foreground (fg) in background (bg)
function result = merge(xpos, ypos, bg, fg, foreground_map )
    %---------------------------------------------------------------------
    % Task c: Merge foreground and background
    %---------------------------------------------------------------------
    
    map = zeros(size(bg));
    map(ypos:ypos+size(foreground_map)-1, xpos:xpos+size(foreground_map, 1)-1,:) = repmat(foreground_map, [1 1 3]);
    
    foreground = zeros(size(bg));
    foreground(ypos:ypos+size(fg,1)-1,xpos:xpos+size(fg,2)-1,:) = fg; %creates fg content
    
    foreground = foreground .* map;
    background = bg .* (1-map) / 255;
    result = foreground + background;
end