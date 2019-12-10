%%loading data 
data_whole=[];
for i=1:19
    feature_vec=[];
    
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
            additional_data=[];
            for addn_data_row=1:m
                addn_data_column_vec=[];
                for addn_iter=1:3:n
                    value=(datamat(addn_data_row,addn_iter)^2)+(datamat(addn_data_row,addn_iter+1).^2)+(datamat(addn_data_row,i+2).^2);
                     addn_data_column_vec=[addn_data_column_vec value];
                end
                additional_data=[additional_data;addn_data_column_vec];
            end
            datamat=[datamat additional_data];
            [m,n]=size(datamat);
            
            mean_feature=mean(datamat);
            variance_feature=var(datamat);
            kurtosis_feature=kurtosis(datamat);
            skewness_feature=skewness(datamat);
            autocorr_feature=[];
            dft_feature=[];
            feature_vec_each_segment=[];
            
            for column_iterator=1:n
                vec1=datamat( :,column_iterator );
                vec2=vec1.';
                autocorr_values=autocorr(vec2);
                autocorr_feature_column_iter=(autocorr_values(1:10)).';
                for each_row=1:10
                    each_row_iter=autocorr_feature_column_iter(each_row,:);
                    autocorr_feature=[autocorr_feature each_row_iter];
            
                end
            end
            %computing Discrete fourier transform using fast fourier
            %transform algorithm
            dft_values_complex=fft(datamat);
            %features cannot be taken in complex form. hence,converted into
            %absolute
            dft_values=abs(dft_values_complex);
            descend_sorted_values=sort(dft_values,'descend');
            peak_dft_values=descend_sorted_values(1:5,:);
            for dft_iter=1:n
                column_dft_values=peak_dft_values(1:5,dft_iter);
                for each_row=1:5
                    each_row_values=column_dft_values(each_row,:);
                    dft_feature=[dft_feature each_row_values];
                end
            end
            row_vec=[mean_feature variance_feature kurtosis_feature skewness_feature autocorr_feature dft_feature];
            feature_vec_each_segment=[feature_vec_each_segment row_vec i];
            feature_vec=[feature_vec;feature_vec_each_segment];
        end
    end
    data_whole=[data_whole;feature_vec];
end
writeMatrix(data_whole,'feature_data.txt');
%%