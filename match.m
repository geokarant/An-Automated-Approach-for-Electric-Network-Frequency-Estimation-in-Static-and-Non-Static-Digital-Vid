function [MCC,MCC_ind,MSDE,MSDE_ind] = match(GT_ENF,ENF)
  

   difLR = numel(GT_ENF) - numel(ENF);

   max_corcoeff=[0 0;0 0];
   max_ind=0;
   min_std=1;
   min_ind=0;

  for l=1:difLR
  ENF_temp=0;
  ENF_temp = GT_ENF(l:l+(numel(ENF)-1));
    
 [R,P] = corrcoef(ENF_temp,ENF');   
 STD = std(ENF_temp - ENF);     


if STD < min_std
    min_std=STD;
    min_ind=l;
end

if (R(1,2))> max_corcoeff(1,2)
    Pmax=P;
    max_corcoeff=R;
    max_ind=l;
end
end


MCC=max_corcoeff;
MCC_ind=max_ind;

MSDE=min_std;
MSDE_ind=min_ind;
end