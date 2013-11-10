% We will be implementing the discrete dyadic wavelet transform using the
% methods from "A Wavelet-Based ECG Delineator: Evaluation on Standard
% Databases"
%
% If the prototype wavelet (mother wavelet) is the derivative of a
% smoothing function, then the Wavelet Transform of a signal at scale a is
% proportional to the derivative of the filtered signal w/ a smoothing
% impulse response @ scale a.
%
% Using literature, we have chosen to use a quadratic spline 

%%% Dummy Data %%%%
experiment_number = 0;
experiment = ['ecg_test_', num2str(experiment_number), '.txt'];
exp_data = load(experiment);
t1 = 1:length(exp_data);

%%% ECG Data from MIT Database %%%
[t1,exp_data] = rdsamp('mitdb/100', 1,100); % 100 data points 


% Design FIR Filter as (1/8) * (d[n+2]+ 3d[n+1] + 3d[n-1]) where d is dirac
% impulse (NON-CAUSAL so first few ouputs will be garbage)

a1 = 1;
b1 = [1/8, 3/8, 0, 3/8];

lowpass_filt = filter(b1,a1,exp_data);

%Plot to see how it looks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plot(t,exp_data,'-.',t,lowpass_filt,'-'), grid on
%legend('Original Data', 'Low-passed Data', 2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Design FIR filter as 2 * (d[n+1] - d[n])

a2 = 1;
b2 = [0, 2, -2, 0];

highpass_filt = filter(b2,a2,exp_data);

%First Scale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure;
% t2 = 1:length(first_scale);
plot(t1,exp_data,'-.',t1,highpass_filt,'-'), grid on
legend('Original Data', 'Scale 1 Data', 2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Time-Invariance problem -> shifted to 

%2nd Scale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
highpass_filt_2 = filter(b2,a2,lowpass_filt);
lowpass_filt_2 = filter(b1,a1, lowpass_filt);
figure;
plot(t1,highpass_filt,'-.',t1,highpass_filt_2,'-'), grid on
legend('Scale 1', 'Scale 2', 2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%3rd Scale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% highpass_filt_3 = filter(b2,a2,lowpass_filt_2);
% lowpass_filt_3 = filter(b1,a1, lowpass_filt_2);
% figure;
% plot(t1,highpass_filt,'-.',t1,highpass_filt_3,'-'), grid on
% legend('Scale 1', 'Scale 3', 2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%4th Scale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% highpass_filt_4 = filter(b2,a2,lowpass_filt_3);
% lowpass_filt_4 = filter(b1,a1, lowpass_filt_3);
% figure;
% plot(t1,highpass_filt,'-.',t1,highpass_filt_4,'-'), grid on
% legend('Scale 1', 'Scale 4', 2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%5th Scale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% highpass_filt_5 = filter(b2,a2,lowpass_filt_4);
% lowpass_filt_5 = filter(b1,a1, lowpass_filt_4);
% figure;
% plot(t1,exp_data,'-.',t1,highpass_filt_5,'-'), grid on
% legend('Data', 'Scale 5', 2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






