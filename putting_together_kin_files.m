%% set up some directories

recon_kin_folder = dir('/Users/christinamerrick/Box Sync/ipsi_ecog/data/ecog_patients/EC171/recon_kin/*recon*');
recon_kin_dir = '/Users/christinamerrick/Box Sync/ipsi_ecog/data/ecog_patients/EC171/recon_kin';

%% creating neural feature mats and stimulus feature mats
total_kin_mat = [];

for block = 1:length(recon_kin_folder)
    
    %% load the time series data 
    
    load([recon_kin_dir filesep() recon_kin_folder(block).name])
    kin_data = kin_mat;
    
    % indicate which block
    block_info = ones(size(kin_data,1),1)*block;
    
    % find if the block was during the near or far condition
    if strfind(recon_kin_folder(block).name,'RC1')
        cond_ind = 1;
    elseif strfind(recon_kin_folder(block).name,'RC2')
        cond_ind = 2;
    elseif strfind(recon_kin_folder(block).name,'RC3')
        cond_ind = 3;
    else
        cond_ind = 4;
    end
    
            
    total_kin_mat = cat(2,total_kin_mat,kin_data);


end    

figure;

plot(total_kin_mat(3,:))


save('total_kin','total_kin_mat','-v7.3')