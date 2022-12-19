function data_filtered=bpfilt(y,Fs,F_pass1,F_pass2,N)
    y_temp=y;
    F_Nyq = Fs/2;

    F_pass1_n     = F_pass1/F_Nyq;                                         
    F_pass2_n     = F_pass2/F_Nyq; 
    
    win           = hamming(N);
    
    b             = fir1(N-1,[F_pass1_n F_pass2_n],'bandpass',win,'scale');
    
    data_filtered = filtfilt(b,1,y_temp);


end
