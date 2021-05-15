# Asymmetry_ECoG_code

#These code go with the paper 'Left Hemisphere Dominance for Bilateral Kinematic Encoding in the Human Brain' which can be found at https://www.biorxiv.org/content/10.1101/2021.05.01.442295v1

#Datafiles that work with this code are located on Zenodo at 10.5281/zenodo.4761390

#Please email cmerrick@berkeley.edu for questions about the data or code

#These code analyze ECoG data collected from six patients implanted with subdural grids as part of their treatment for intractable epilepsy. Patients performed an instructed-delay reaching task to targets on a touchscreen that was placed on their overbed table.

#Each block of trials (separated into different datasets) consisted of 40 trials performed with either their left or their right arm. Each patient performed two blocks per arm, with the order counterbalanced. For each block, every patient has two datafiles, one that contains a structure with the neural data which is titled by the patient ID, hemisphere of implantation, arm that was used to reach and the block number (i.e., R4_RightHemisphere_RightHand_1) and a separate file of the kinematics that also states the patient number, but then says 'Kin", the arm they reached with and the block number (i.e., R4_Kin_Righthand_1). For the neural dataset it is a matlab structure called SDATA that contains the neural time series for each electrode (time x elec) under SDATA.data. There is information about the sampling rate and channel labels under SDATA.info. For the kinematics, it is a matlab matrix called kin_mat that has seven different kinematics by time. The seven different kinematic variables are: position (across all three dimensions), speed, position in the X direction, position in the Y direction, position in the Z direction, spherical angle Theta which separates targets horizontally and spherical angle Phi which separates targets vertically. 

#Intracranial data was preprocessed in matlab and each block was saved separately. No filtering has been applied to the neural data yet except for a 60 hz line filter to remove noise from electronics plugged into outlets that were in the ICU room. To examine the 'High frequency activity' component of the signal (also called high frequency broadband or high gamma) please use the matlab script titled 'Create_HFB_from_SDATA'. This code will simultaneously extract the high frequency component and also concatenate all the blocks from one patient. Data saved from this can then be loaded into the kinematic encoding python notebook script. 

#Kinematic data is also saved by block - to concatenate them together to load into the encoding model please use the matlab script titled 'putting_together_kin_files'. They can then be uploaded into the encoding model script.

#The primary measure we used from the kinematic encoding model is the average correlation between the held-out predictions and the actual HFA signal across the five test sets. What is reported in the paper is R^2 which is the square of the correlation which can be interpreted as how much the kinematics are able to account for neural variance and is bounded between 0 and 1. 

#By Christina Merrick
#University of California, Berkeley

