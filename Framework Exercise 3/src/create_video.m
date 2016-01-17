function create_video(video_filename, input_directory,file_extension)
    %---------------------------------------------------------------------
    % Task d: Create output video of all resulting frames
    %---------------------------------------------------------------------
    writer = VideoWriter(video_filename);
    %set framerate and open writer
    writer.FrameRate = 24;      
    open(writer);
    
    %load frame names
    frames = dir([input_directory '/*.' file_extension]);   
    
    % create video
    for j = 1:numel(frames)
        writeVideo(writer,imread([input_directory '/' frames(j).name])); 
    end
  
    close(writer);
end

