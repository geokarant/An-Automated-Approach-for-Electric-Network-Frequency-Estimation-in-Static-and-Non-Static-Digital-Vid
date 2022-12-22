
load('GT_ENF'); %load ground truth ENF values

% read video and compute mean pixel value per frame
v = VideoReader('MOV1_20190505_110016A.mp4');
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
F_pass1=9.9;    % choose between 1st and 2nd harmonic
F_pass2=10.1;

%F_pass1=9.69;  % choose between 1st and 2nd harmonic
%F_pass2=9.89;

nffttimes=4;
Fs=30;



k=1;
a=1;
b=2;


ordervals=[41,81,311,511]; % filter orders N
nn = numel(ordervals);


for i=1:nn;
        k=1;
    for framesec=1:4:90
        N = ordervals(i);
        data_filtered=bpfilt(y,Fs,F_pass1,F_pass2,N);  % bandpass data filtering
    	ENF = enfest(data_filtered,framesec,nffttimes,Fs);  % enf estimation

    	[MCC,MCC_ind,MSDE,MSDE_ind] = match(GT_ENF,ENF);   % corcoef and mSDE

        results_stft(a,k)=framesec;
        results_stft(b,k)=MCC(1,2);
        k=k+1;
    end
 a=a+2;
 b=b+2;
end


figure (3)
set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto')
plot(results_stft(1,:),results_stft(2,:));
hold on
plot(results_stft(1,1:23),results_stft(4,:),'-o');
plot(results_stft(1,:),results_stft(6,:),'-x');
plot(results_stft(1,:),results_stft(8,:),'--');
grid on
xlabel('Segment duration D (s)','Fontsize',25)
ylabel('MCC','Fontsize',25)
legend('\nu=41','\nu=81','\nu=311','\nu=511')

