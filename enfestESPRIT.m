function ENF = enfestESPRIT(data_filtered,framesec,nffttimes,Fs)
        

    
        signal_len     = length(data_filtered);
        T              = signal_len/Fs;
        frame_length   = fix(framesec * Fs);
     shift_amount   = fix(Fs);
        nfft= nffttimes*frame_length;
        nb_frames = ceil((signal_len - frame_length)/shift_amount)+1;
        nomval=10;
        w1 = rectwin(frame_length);
       % w1 = parzenwin(frame_length);
        
         data_filtered1=data_filtered(1:signal_len);
         
         rown = ceil((1+nfft)/2);           
         coln = 1+fix((signal_len-frame_length)/shift_amount);     
         
         indx = 0;
         col = 1;
         tic
         
         while indx + frame_length <= signal_len
             xw = data_filtered1(indx+1:indx+frame_length).*w1';
              
             X = esprit(xw,3,10);
             stft(:, col) = X(:,1);
              
              
              
              
             indx = indx + shift_amount;
             col = col + 1;
         end
         
         toc

         t = (frame_length/2:shift_amount:frame_length/2+(coln-1)*shift_amount)/Fs;
         f = (0:rown-1)*Fs/nfft;
         
       
        FREQS_ESPRIT = stft(:,:).*(Fs/(2*pi));
      FREQS_ESPRIT=abs(FREQS_ESPRIT);
  
      
      
      
      
          for jj=1:numel(FREQS_ESPRIT(1,1:end));
           ENF_estimation1(1,jj)=(FREQS_ESPRIT(2,jj));
          end
 
         
         
       
          ENF=ENF_estimation1;
         


end