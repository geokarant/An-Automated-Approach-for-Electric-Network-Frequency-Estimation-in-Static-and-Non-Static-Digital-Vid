function ENF = enfest(data_filtered,framesec,nffttimes,Fs)
        

    
        signal_len     = length(data_filtered);
        T              = signal_len/Fs;
        frame_length   = fix(framesec * Fs);
         shift_amount   = fix(Fs);
       % shift_amount   = frame_length/4;
        nfft= nffttimes*frame_length;
        nb_frames = ceil((signal_len - frame_length)/shift_amount)+1;
        
        w1 = rectwin(frame_length);
                w2 = rectwin(frame_length);

       % w1 = parzenwin(frame_length);
        
         data_filtered1=data_filtered(1:signal_len);
         
         rown = ceil((1+nfft)/2);           
         coln = 1+fix((signal_len-frame_length)/shift_amount);     
         stft = zeros(rown, coln); 
         
         indx = 0;
         col = 1;
         tic
         
         while indx + frame_length <= signal_len
             xw = data_filtered1(indx+1:indx+frame_length).*w1';
               X = fft(xw, nfft);
           % X=btse(xw,w2,nfft);
              % X = fastIAA(xw);
              stft(:, col) = X(1:rown);
             
              
              
              
              
             indx = indx + shift_amount;
             col = col + 1;
         end
         
         toc

         t = (frame_length/2:shift_amount:frame_length/2+(coln-1)*shift_amount)/Fs;
         f = (0:rown-1)*Fs/nfft;
         
         for ii=1:col-1
          Power_Spectrum(:,ii)=(abs(stft(:,ii)).^2)/frame_length;
         end

         power_vector=log10((Power_Spectrum));
         
         
         [~, index] = max(power_vector);
         delta = QuadraticInterpolation(power_vector,index,f);
          maxFreqs=f(index);
          ENF=(maxFreqs+delta);
         


end