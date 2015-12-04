function [bok,scribble_count, fg_scribbles, histo_fg, histo_bg] = get_histograms(input_directory,file_list,bins)     
    % load reference frame and its foreground and background scribbles
    bok=false;
    scribble_count=0;
    reference_frame=[];
    fg_scribbles=[];
	bg_scribbles=[];
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
    
	% all pixels other then the scribbles become 0
    fg_scribbles = imabsdiff(frames_scribbles(:,:,:,1), reference_frame);    
    bg_scribbles = imabsdiff(frames_scribbles(:,:,:,2), reference_frame);

	% binary scribbles map of fore- and background, the marked pixesl become 1
	fg_scribbles(fg_scribbles>1) = 1;
    bg_scribbles(bg_scribbles>1) = 1;
	
    %----------------------------------------------------------------------
    % Task b: Generate color models for foreground and background
    %----------------------------------------------------------------------
    
	% matrix with the color of the marked pixels
    fg_scribbles_color = fg_scribbles .* reference_frame;
    bg_scribbles_color = bg_scribbles .* reference_frame;
	
	% color histograms for the fore- and background scribbles
    histo_fg = colHist(fg_scribbles_color(:,:,1), fg_scribbles_color(:,:,2), fg_scribbles_color(:,:,3), bins);
    histo_bg = colHist(bg_scribbles_color(:,:,1), bg_scribbles_color(:,:,2), bg_scribbles_color(:,:,3), bins);
end