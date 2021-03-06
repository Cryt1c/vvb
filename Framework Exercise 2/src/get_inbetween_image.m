
function new_image = get_inbetween_image(image, u, v)
    %---------------------------------------------------------------------
    % Task b: Generate new x- and y-values of new frame
    %---------------------------------------------------------------------
    
    % initialize meshgrid
    height = size(image, 1);
    width = size(image, 2);
    image = double(image);
    [x,y] = meshgrid(1:width, 1:height);
    
    % take half of the offset to create new frame
    x = x - (u*0.5);
    y = y - (v*0.5);
    
    % makes sure that the values don't exceed the size of the frame
    x = min(max(x,1), width);
    y = min(max(y,1), height);
    
    %---------------------------------------------------------------------
    % Task c: Generate new frame
    %---------------------------------------------------------------------
    
    % interpolate between two images for all three RGB layers
    new_image = zeros(size(image));
    new_image(:,:,1) = interp2(image(:,:,1),x,y);
    new_image(:,:,2) = interp2(image(:,:,2),x,y);
    new_image(:,:,3) = interp2(image(:,:,3),x,y);
end
