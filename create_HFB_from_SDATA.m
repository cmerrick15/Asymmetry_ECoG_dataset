%% creating high frequency activity timeseries from SDATA %%

neural_raw_files = dir('/Users/christinamerrick/Box Sync/ipsi_ecog/data/ecog_patients/EC171/mat_files/*EC171*');
neural_raw_dir = '/Users/christinamerrick/Box Sync/ipsi_ecog/data/ecog_patients/EC171/mat_files';


hfb_data = [];
data_mat = [];


for block = 1:length(neural_raw_files)
    
    %% load the time series data 
    
    load([neural_raw_dir filesep() neural_raw_files(block).name])
    raw_timeseries = SDATA.data;
          
    data = raw_timeseries;

    clear raw_timeseries % to save disk space
    

    sr = 1000;

    low_band = 70; % lower bound of HFB
    high_band = 200; % upper bound of HFB
    hfb_log = round(logspace(log10(low_band),log10(high_band),6)); % creating logspace from lowerbound to upperbound

    % init
    HFB = zeros(size(data,1),size(data,2),1);
    hfb_bands = zeros(size(data,1),size(data,2),length(hfb_log));
    z_num = [];
    hfb_num = [];
    

    % for high frequency broadband
    for feat = 1:length(hfb_log)-1
        % hilbert
        hfb_bands(:,:,feat) = abs(hilbert(bandPassFilter(hfb_log(feat), hfb_log(feat+1),double(data),sr)));
    end

     hfb_bands_mat = [];
    
    % downsample 
    for feat = 1:length(hfb_log)-1
        hfb_bands_mat(:,:,feat) = downsample(hfb_bands(:,:,feat),10);
    end
    
        
    hfb_data = cat(1,hfb_data,hfb_bands_mat);

end


z_num = [];
hfb_data_z = [];

for feat = 1:length(hfb_log)-1
    z_num(:,:,feat) = bsxfun(@minus, hfb_data(:,:,feat), mean(hfb_data(:,:,feat))); % calculate numerator
    hfb_data_z(:,:,feat) = bsxfun(@rdivide, z_num(:,:,feat), std(hfb_data(:,:,feat))); % z-scoring
end


hfb_avg_z = mean(hfb_data_z,3);

