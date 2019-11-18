for i=1:19
    if i<10
        str_activity_no=int2str(i);
        str_0='0';
        str_a='a';
        str_activity_name=strcat(str_a,str_0,str_activity_no);
    else
        str_activity_no=int2str(i);
        str_a='a';
        str_activity_name=strcat(str_a,str_activity_no);
           
    end
         
    for j=1:8
        str_person_no=int2str(j);
        str_p='p';
        str_person_name=strcat(str_p,str_person_no);
           
        for k=1:60
            if k<10
                str_segment_no=int2str(k);
                str_0='0';
                str_s='s';
                str_segment_name=strcat(str_s,str_0,str_segment_no);
            else
                str_segment_no=int2str(k);
                str_s='s';
                str_segment_name=strcat(str_s,str_segment_no);
           
            end
            datamat=load(['data/' str_activity_name '/' str_person_name '/' str_segment_name '.txt']);
            [m,n]=size(datamat);
            mean_feature=mean(datamat);
            variance_feature=var(datamat);
            kurtosis_feature=kurtosis(datamat);
            skewness_feature=skewness(datamat);
           
   
        end
    end
end
