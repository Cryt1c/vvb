%xpos, ypos: position for foreground shadow in background
function bg_with_shadow = add_shadow(xpos, ypos, bg, foreground_map )
    %---------------------------------------------------------------------
    % Task b: Add shadow of foreground object to background
    %---------------------------------------------------------------------       
   
    %create a transformstructure
    tfs = maketform('projective',[10 -3 0; 10 5 0; 0 0 1]); 
    %transform the foreground to get a shadow with a proper angle
    shadowmap = imtransform(foreground_map, tfs, 'XYScale', [12 22]); 
        
    %resize shadowmap and copy it to its coordinates
    shadowrs = zeros(size(bg, 1), size(bg,2));
    shadowrs(ypos:ypos+size(shadowmap,1)-1,xpos:xpos+size(shadowmap,2)-1) = shadowmap;
    
    %initialise result matrix and choose shadow color
    bg_with_shadow = zeros(size(bg));
    shadowColor = [15 15 15]; 
    %transparency factor of the shadow
    t = 0.8; 
    %add the shadow information for every dimension                                          
    for i = 1:3
        chosenColor = shadowrs * shadowColor(i) * t;
        backgroundColor = (double(bg(:,:,i)) .* shadowrs) * (1-t);
        nonShadowColor = double(bg(:,:,i)) .* (1-shadowrs);
        bg_with_shadow(:,:,i) = chosenColor + backgroundColor + nonShadowColor; 
    end
end

