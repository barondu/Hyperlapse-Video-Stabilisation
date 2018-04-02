function frameFiltering(path, start_f, end_f)

    if ~exist('inputImage.mat')
        inputImage = load_sequence_color(path,'op',start_f,99+start_f,5,'png');
        inputImage = imresize(inputImage, 0.3);

        for e = 99+start_f+1:100:end_f
            disp(e);
            patchImage = load_sequence_color(path,'op',e,99+e,5,'png');
            patchImage = imresize(patchImage, 0.3); 
            inputImage = cat(4,inputImage, patchImage);
        end
        save('inputImage.mat', 'inputImage');   
    else
        load('inputImage.mat', 'inputImage');
    end
    
    
    if ~exist('d_matrix.mat')
        d_matrix = compute_dist(inputImage);
        save('d_matrix.mat', 'd_matrix');
    else
        load('d_matrix.mat', 'd_matrix');
    end
    
    

    


end