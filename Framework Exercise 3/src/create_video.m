function create_video(video_filename, input_directory,file_extension)
    %---------------------------------------------------------------------
    % Task d: Create output video of all resulting frames
    %---------------------------------------------------------------------
    writer = VideoWriter(video_filename);
    writer.FrameRate = 30;      %set framerate and open writer
    open(writer);
    
    
    frame_list = dir([input_directory '/*.' file_extension]);   %load frame names
    
    for j = 1:numel(frame_list)
        writeVideo(writer,imread([input_directory '/' frame_list(j).name])); % create video
    end
    
    close(writer);
end

