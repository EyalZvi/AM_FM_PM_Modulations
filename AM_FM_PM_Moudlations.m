%--------------------------------------------------------------------------
%---------------------------AM and FM Modulation---------------------------
%--------------------------------------------------------------------------
[v_m,fs] = audioread('in-the-air.wav');
v_m = v_m(:,1);
%sound(v_m,fs);
Ts = 1/fs;
N = length(v_m);
t = 0:Ts:(N-1)*Ts;
f = linspace(-fs/2,fs/2,N);
V_m = fftshift(fft(v_m))/sqrt(N);
%-----------------------------------1.1------------------------------------
figure('Name','Question: 1.1.1');
subplot(2,1,1);
plot(t,v_m,color='#0072BD');
grid();
title('Input Signal - Time Domain');
xlabel('Time [Sec]');
ylabel('v_m(t)');
subplot(2,1,2);
plot(f,V_m,color='#0072BD');
grid();
title('Input Signal - Frequency Domain');
xlabel('Frequency [Hz]');
ylabel('V_m(f)');
%----1.1.2----
f_c = 15*10^3;
fm = 1.15*10^4;
BW = 2*pi*fm;
%-----------------------------------1.2------------------------------------
% -----------------------------------|
% Parameters: k_FM = 0.02, noise = 0 |
% -----------------------------------|
figure('Name','Question: 1.2.2');
title_1_2 = 'AM with carrier modulation - Frequency Domain';
v_AM = mod_with_noise(v_m,1,0,N,f,fs,f_c,0.02,title_1_2,'V_A_M(f)');
%----1.2.3----
%sound(v_AM,fs);
%-----------------------------------1.3------------------------------------
% --------------------------------------|
% Parameters: k_AM = 0.02, noise = 0.02 |
% --------------------------------------|
figure('Name','Question: 1.3.2');
title_1_3 = 'Fourier transform of x_r(t) - Frequency Domain';
x_r = mod_with_noise(v_m,1,0.02,N,f,fs,f_c,0.02,title_1_3,'X_r(f)');
%sound(x_r,fs);
%-----------------------------------1.4------------------------------------
%----1.4.1----
x_L = bandpass(x_r,[f_c-fm f_c+fm],fs);
X_L = fftshift(fft(x_L))/sqrt(N);
figure('Name','Question: 1.4.1');
plot(f,X_L,color='#0072BD');
grid();
title('FT of the received signal after BPF - Frequency Domain');
xlabel('Frequency [Hz]');
ylabel('X_L(f)');
%----1.4.2----
title_time =['Demodulated received signal with LPF and the original ' ...
    'signal - Time Domain'];
title_freq =['Demodulated received signal with LPF and the original ' ...
    'signal - Frequency Domain'];
x_d_LPF = demod_and_compare(x_L,1,v_m,V_m,t,N,f,fs,f_c,0.02,title_time, ...
    title_freq,"Question: 1.4.2");
%----1.4.3----
%sound(x_d_LPF,fs);
%----1.4.4----
xcorr_AM_z1 = xcorr(x_d_LPF,v_m,0,'coeff');
%-----------------------------------1.5------------------------------------
% -------------------------------------|
% Parameters: k_AM = 0.02, noise = 0.1 |
% -------------------------------------|
%----1.5.1::1.3----
figure('Name','Question: 1.5.1::1.3');
title_1_5_1_1_3 = 'Fourier transform of x_r(t) - Frequency Domain';
x_r = mod_with_noise(v_m,1,0.1,N,f,fs,f_c,0.02,title_1_5_1_1_3,'X_r(f)');
%----1.5.1::1.4.1----
x_L = bandpass(x_r,[f_c-fm f_c+fm],fs);
X_L = fftshift(fft(x_L))/sqrt(N);
figure('Name','Question: 1.5.1::1.4.1');
plot(f,X_L,color='#0072BD');
grid();
title('FT of the received signal after BPF - Frequency Domain');
xlabel('Frequency [Hz]');
ylabel('X_L(f)');
%----1.5.1::1.4.2----
title_time =['Demodulated received signal with LPF and the original ' ...
    'signal - Time Domain'];
title_freq =['Demodulated received signal with LPF and the original ' ...
    'signal - Frequency Domain'];
x_d_LPF = demod_and_compare(x_L,1,v_m,V_m,t,N,f,fs,f_c,0.02,title_time, ...
    title_freq,"Question: 1.5.1::1.4.2");
%----1.5.1::1.4.3----
%sound(x_d_LPF,fs);
%----1.5.1::1.4.4----
xcorr_AM_z2 = xcorr(x_d_LPF,v_m,0,'coeff');
% -------------------------------------------------------------------------
% --------------------------------------|
% Parameters: k_FM = 0.02, noise = 0.02 |
% --------------------------------------|
%----1.5.2::1.3----
figure('Name','Question: 1.5.2::1.3');
title_1_5_2_1_3 = 'Fourier transform of x_r(t) - Frequency Domain';          
x_r = mod_with_noise(v_m,2,0.02,N,f,fs,f_c,0.02,title_1_5_2_1_3,'X_r(f)');
%----1.5.2::1.4.1----
x_L = bandpass(x_r,[f_c-fm f_c+fm],fs);
X_L = fftshift(fft(x_L))/sqrt(N);
figure('Name','Question: 1.5.2::1.4.1');
plot(f,X_L,color='#0072BD');
grid();
title('FT of the received signal after BPF - Frequency Domain');
xlabel('Frequency [Hz]');
ylabel('X_L(f)');
%----1.5.2::1.4.2----
title_time =['Demodulated received signal with LPF and the original ' ...
    'signal - Time Domain'];
title_freq =['Demodulated received signal with LPF and the original ' ...
    'signal - Frequency Domain'];
x_d_LPF = demod_and_compare(x_L,2,v_m,V_m,t,N,f,fs,f_c,0.02,title_time, ...
    title_freq,"Question: 1.5.2::1.4.2");
%----1.5.2::1.4.3----
%sound(x_d_LPF,fs);
%----1.5.2::1.4.4----
xcorr_FM_z1 = xcorr(x_d_LPF,v_m,0,'coeff');
% -------------------------------------------------------------------------
% -------------------------------------|
% Parameters: k_FM = 0.02, noise = 0.1 |
% -------------------------------------|
%----1.5.2::1.5.1::1.3----
figure('Name','Question: 1.5.2::1.5.1::1.3');
title_1_5_2_1_3 = 'Fourier transform of x_r(t) - Frequency Domain';
x_r = mod_with_noise(v_m,2,0.1,N,f,fs,f_c,0.02,title_1_5_2_1_3,'X_r(f)');
%----1.5.2::1.5.1::1.4.1----
x_L = bandpass(x_r,[f_c-fm f_c+fm],fs);
X_L = fftshift(fft(x_L))/sqrt(N);
figure('Name','Question: 1.5.2::1.5.1::1.4.1');
plot(f,X_L,color='#0072BD');
grid();
title('FT of the received signal after BPF - Frequency Domain');
xlabel('Frequency [Hz]');
ylabel('X_L(f)');
%----1.5.2::1.5.1::1.4.2----
title_time =['Demodulated received signal with LPF and the original ' ...
    'signal - Time Domain'];
title_freq =['Demodulated received signal with LPF and the original ' ...
    'signal - Frequency Domain'];
x_d_LPF = demod_and_compare(x_L,2,v_m,V_m,t,N,f,fs,f_c,0.02,title_time, ...
    title_freq,"Question: 1.5.2::1.5.1::1.4.2");
%----1.5.2::1.5.1::1.4.3----
%sound(x_d_LPF,fs);
%----1.5.2::1.5.1::1.4.4----
xcorr_FM_z2 = xcorr(x_d_LPF,v_m,0,'coeff');
%--------------------------------------------------------------------------
%-------------------------------- Functions -------------------------------
%--------------------------------------------------------------------------
function x_r = mod_with_noise(v_m,modtype,noise,N,f,fs,f_c,k,plt_title,y_label)
    z_t = noise*randn(1,N).';
    if isequal(modtype,1)
        % AM Modulation - Type 1:
        v_AM = ammod(v_m,f_c,fs,0,k);
        x_r = v_AM + z_t;
    else
        % FM Modulation - Type 2:
        f_d = 10*10^3;
        v_FM = fmmod(v_m,f_c,fs,f_d);
        x_r = v_FM + z_t;
    end
    X_r = fftshift(fft(x_r))/sqrt(N);
    plot(f,X_r, color='#0072BD');
    title(plt_title);
    grid();
    xlabel('Frequency [Hz]');
    ylabel(y_label);
end

function x_d_LPF = demod_and_compare(x_L,demodtype,v_m,V_m,t,N,f,fs,f_c,k, ...
    title_time,title_freq,qnum)
    if isequal(demodtype,1)
        % AM Demodulation - Type 1:
        x_d = amdemod(x_L,f_c,fs,0,k);
        x_d_LPF = lowpass(x_d,0.7*10^4,fs);
    else
        % FM Demodulation - Type 2:
        f_d = 10*10^3;
        x_d = fmdemod(x_L,f_c,fs,f_d);
        x_d_LPF = lowpass(x_d,0.7*10^4,fs);
    end
    figure('Name',qnum+'.1');
    plot(t,x_d_LPF,color='#0072BD',marker='*');
    grid();
    title(title_time);
    xlabel('Time [Sec]');
    hold on;
    plot(t,v_m,color='#A2142F');
    legend('x_d(t)','v_m(t)');
    % --------
    X_d_LPF = fftshift(fft(x_d_LPF))/sqrt(N);
    figure('Name',qnum+'.2');
    plot(f,V_m,color='#0072BD', marker='*');
    grid();
    title(title_freq);
    xlabel('Frequency [Hz]');
    hold on;
    plot(f,X_d_LPF,color='#A2142F');
    legend('V_m(f)','X_d(f)');
end
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------