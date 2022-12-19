
% read video and compute mean pixel value per frame

v = VideoReader('MOV3_20190512_215145A.mp4');
frames=v.Duration*29.98;

tic
for i=1:fix(frames);
    frame = read(v,i);
    


    %%%proposed SLIC approach
    
    if i==1
       I = rgb2gray(frame);
       [L,NumLabels] = superpixels(I,20);
       idx = label2idx(L);
    end
    
    
    I = rgb2gray(frame);
    

    for labelVal = 1:NumLabels
        redIdx = idx{labelVal};
        outputImage(labelVal) = mean(I(redIdx));
    end  
    med_val=median(outputImage);
    xxx=(outputImage>=(med_val/3));
    
    frame_val(i) = mean(outputImage(xxx));
    y=frame_val;
%    
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
toc
 

%data_filtered=bandpass(Y,[49.9 50.1],Fs);
F_pass1=9.9;
F_pass2=10.1;

F_pass1=9.69;
F_pass2=9.89;

N= 511;
Fs=30;

clear ENF


data_filtered=bpfilt(y,Fs,F_pass1,F_pass2,N);  % bandpass data filtering


framesec=17 ;
nffttimes=4;
%ENF = enfest(data_filtered,framesec,nffttimes,Fs);  % enf estimation
ENF = enfestESPRIT(data_filtered,framesec,nffttimes,Fs);  % enf estimation with ESPRIT - comment the previous line if you want to run for ESPRIT
[MCC,MCC_ind,MSDE,MSDE_ind] = match(GT_ENF,ENF);   % corcoef and mSDE






figure (3)
set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto')
plot(results_stft_n41(1,:),results_stft_n41(2,:));
hold on
plot(results_stft_With_slic_81(1,1:23),results_stft_With_slic_81(2,1:23),'-o');
plot(results_stft_n311(1,:),results_stft_n311(2,:),'-x');
plot(results_stft_n511(1,:),results_stft_n511(2,:),'--');
grid on
xlabel('Segment duration D (s)','Fontsize',25)
ylabel('MCC','Fontsize',25)
legend('\nu=41','\nu=81','\nu=311','\nu=511')
%xlim([0 1800])
%ylim([49.96 50.03])






