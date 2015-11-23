function [bok,scribble_count, fg_scribbles, histo_fg, histo_bg] = get_histograms(input_directory,file_list,bins)     
    % load reference frame and its foreground and background scribbles
    bok=false;
    scribble_count=0;
    reference_frame=[];
    fg_scribbles=[];
    histo_fg=[];
    histo_bg=[];
    for j = 1:numel(file_list)
        frame_name = file_list(j).name;

        if (strcmp(frame_name(1),'s') == 1) % scribble files begin with s
           frame = imread([input_directory '/' frame_name]); %read image      
           scribble_count=scribble_count +1;
           frames_scribbles(:,:,:,scribble_count) = frame(:,:,:);             
        elseif (strcmp(frame_name(1),'r') == 1) % reference file begin with r
           frame = imread([input_directory '/' frame_name]); % read image     
           reference_frame=uint8(frame(:,:,:));
        end
    end
    frames_scribbles=uint8(frames_scribbles);
   
    if ((scribble_count==2) && (~isempty(reference_frame))) 
        bok=true;
    else 
        return;
    end;
    
    %----------------------------------------------------------------------
    % Task a: Filter user scribbles to indicate foreground and background   
    %----------------------------------------------------------------------
    
    diff = imabsdiff(frames_scribbles(:,:,:,1), reference_frame);    
    bdiff = imabsdiff(frames_scribbles(:,:,:,2), reference_frame);

    %----------------------------------------------------------------------
    % Task b: Generate color models for foreground and background
    %----------------------------------------------------------------------
    
    diff(diff>1) = 1;
    bdiff(bdiff>1) = 1;
    fg_scribbles = diff;
    
    diff = diff .* reference_frame;
    bdiff = bdiff .* reference_frame;
%     imshow(diff);
%     figure;
%     imshow(bdiff);
    histo_fg = colHist(diff(:,:,1), diff(:,:,2), diff(:,:,3), 256);
    histo_bg = colHist(bdiff(:,:,1), bdiff(:,:,2), diff(:,:,3), 256);
end