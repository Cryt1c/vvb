function output = change_illumination(frame, luma_factor)
    %---------------------------------------------------------------------
    % Task a: Adjust brightness and resize foreground object
    %---------------------------------------------------------------------
    frame = rgb2hsv(frame);
    %change brightness on the value (third) channel
    frame(:,:,3) = frame(:,:,3) * luma_factor;     
    output = hsv2rgb(frame);
end

