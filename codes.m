%%
clear all; clc; close all
datapath = 'E:\data_set\';
datafile = dir(fullfile(datapath,'*.set'));
dataname = {datafile.name};
a = {'S  1'  'S  2'  'S  3'  'S  4' 'S  6'  'S  7'}; 
for i = 1:length(dataname)
    EEG = pop_loadset('filename',dataname{i},'filepath',datapath); 
    EEG = eeg_checkset( EEG );    
    for j = 1:length(a)
        EEG_0 = pop_epoch( EEG, a(j), [-200 1], 'newname', 'datasets pruned with ICA', 'epochinfo', 'yes'); 
        EEG_0 = eeg_checkset( EEG_0 );
        EEG_0 = pop_rmbase( EEG_0, [-200 0]); 
        EEG_0 = eeg_checkset( EEG_0 );
        EEG_1(i,j,:,:) = squeeze(mean(EEG_0.data,3)); 
    end 
end
N100_interval=find((EEG.times>=100)&(EEG.times<=140)); 
P200_interval=find((EEG.times>=150)&(EEG.times<=200)); 
N250_interval=find((EEG.times>=210)&(EEG.times<=300));
LPP_interval=find((EEG.times>=400)&(EEG.times<=800));
N100_M_A = squeeze(mean(EEG_1(:,:,:,N100_interval),4));
P200_M_A = squeeze(mean(EEG_1(:,:,:,P200_interval),4));
N250_M_A = squeeze(mean(EEG_1(:,:,:,N250_interval),4));
LPP_M_A = squeeze(mean(EEG_1(:,:,:,LPP_interval),4));
% N100
for i = 1:size(EEG_1,1)
    for j = 1:size(EEG_1,2) 
    N100d =squeeze(EEG_1(i,j,:,N100_interval)); 
    [peak_amplitude_temp, peak_latency_temp] = min(N100d,[],2);
    peak_latency_temp = EEG.times(1,find(EEG.times==100) + peak_latency_temp - 1)';
    N100_peak_amp(i,j,:) = peak_amplitude_temp;
    N100_peak_L(i,j,:) = peak_latency_temp;
    end
end
N100_M_amplitude1=squeeze(mean(N100_M_A(:,:,[7 50 10]),3));% frontal lobe
N100_M_amplitude2=squeeze(mean(N100_M_A(:,:,[23 52 26]),3));% central lobe
N100_M_amplitude3=squeeze(mean(N100_M_A(:,:,[39 54 42]),3));% parietal lobe

N100_latency1=squeeze(mean(N100_peak_L(:,:,[7 50 10]),3));
N100_latency2=squeeze(mean(N100_peak_L(:,:,[23 52 26]),3));
N100_latency3=squeeze(mean(N100_peak_L(:,:,[39 54 42]),3));
% P200
for i = 1:size(EEG_1,1)
    for j  = 1:size(EEG_1,2)
    P200d =squeeze(EEG_1(i,j,:,P200_interval)); 
    [peak_amplitude_temp, peak_latency_temp] = max(P200d,[],2);
    peak_latency_temp = EEG.times(1,find(EEG.times==150) + peak_latency_temp - 1)';
    P200_peak_amp(i,j,:) = peak_amplitude_temp;
    P200_peak_L(i,j,:) = peak_latency_temp;
    end
end
P200_M_amplitude1=squeeze(mean(P200_M_A(:,:,[7 50 10]),3));
P200_M_amplitude2=squeeze(mean(P200_M_A(:,:,[23 52 26]),3));
P200_M_amplitude3=squeeze(mean(P200_M_A(:,:,[39 54 42]),3));

P200_latency1=squeeze(mean(P200_peak_L(:,:,[7 50 10]),3));
P200_latency2=squeeze(mean(P200_peak_L(:,:,[23 52 26]),3));
P200_latency3=squeeze(mean(P200_peak_L(:,:,[39 54 42]),3));
% N250
for i = 1:size(EEG_1,1)
    for j = 1:size(EEG_1,2)
    N250d =squeeze(EEG_1(i,j,:,N250_interval)); 
    [peak_amplitude_temp, peak_latency_temp] = min(N250d,[],2);
    peak_latency_temp = EEG.times(1,find(EEG.times==210) + peak_latency_temp - 1)';
    N250_peak_amp(i,j,:) = peak_amplitude_temp;
    N250_peak_L(i,j,:) = peak_latency_temp;
    end
end
N250_M_amplitude1=squeeze(mean(N250_M_A(:,:,[7 50 10]),3));
N250_M_amplitude2=squeeze(mean(N250_M_A(:,:,[23 52 26]),3));
N250_M_amplitude3=squeeze(mean(N250_M_A(:,:,[39 54 42]),3));

N250_latency1=squeeze(mean(N250_peak_L(:,:,[7 50 10]),3));
N250_latency2=squeeze(mean(N250_peak_L(:,:,[23 52 26]),3));
N250_latency3=squeeze(mean(N250_peak_L(:,:,[39 54 42]),3));
% LPP
for i = 1:size(EEG_1,1)
    for j  = 1:size(EEG_1,2)
    LPPd =squeeze(EEG_1(i,j,:,LPP_interval)); 
    [peak_amplitude_temp, peak_latency_temp] = max(LPPd,[],2);
    peak_latency_temp = EEG.times(1,find(EEG.times==400) + peak_latency_temp - 1)';
    LPP_peak_amp(i,j,:) = peak_amplitude_temp;
    LPP_peak_L(i,j,:) = peak_latency_temp;
    end
end
LPP_M_amplitude1=squeeze(mean(LPP_M_A(:,:,[7 50 10]),3));
LPP_M_amplitude2=squeeze(mean(LPP_M_A(:,:,[23 52 26]),3));
LPP_M_amplitude3=squeeze(mean(LPP_M_A(:,:,[39 54 42]),3));

LPP_latency1=squeeze(mean(LPP_peak_L(:,:,[7 50 10]),3));
LPP_latency2=squeeze(mean(LPP_peak_L(:,:,[23 52 26]),3));
LPP_latency3=squeeze(mean(LPP_peak_L(:,:,[39 54 42]),3));



