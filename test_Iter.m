
close all;

%% -10 -5 0 5 dB sum_rate����������ı仯
global Nu;
global Nb;
global h_freq;
global Omega;
load h_freq;
load Omega;
NumLoop = 20;
LoopTime = 1;
[Nr,Nt,~] = size(Omega);
Nu = 4;                                       %��channel_generation��Nu Nt ���Ӧ
Nb = 3;

SNR = -10:10:20;
NSNR = length(SNR);
ITER = 0:9;
NITER = length(ITER);
eps = 1e-4;                                   %��ֵ
rate_ergodic = zeros(NSNR,NITER);
Lambda_ini = zeros(Nt,Nb,NSNR);
%% ����汾���ԣ����ǵ���test_iter2
for nSNR = 1:NSNR
    snr = 10^(SNR(nSNR)/10);
    for i = 1:Nb
        Lambda_ini(:,i,nSNR) = snr/Nt;
    end
    Lambda_i = Lambda_ini;
    rate_ergodic(nSNR,1) = cal_rate_ergodic(Lambda_ini(:,:,nSNR));  % ����0��
    for iter = 1:NITER-1                                            %����1~9��
        [Lambda_new,rate_ergodic(nSNR,iter+1),~]=MM_optimal(Lambda_i,snr);
        if (rate_ergodic(nSNR,iter+1)-rate_ergodic(nSNR,iter))/rate_ergodic(nSNR,iter) <eps
            rate_ergodic(nSNR,iter+1:NITER) = rate_ergodic(nSNR,iter);
            break;
        end
        Lambda_i = Lambda_new;
    end
    
    
end

figure;
hold on;
plot(ITER,rate_ergodic(4,:),'r-s','LineWidth',1);
plot(ITER,rate_ergodic(3,:),'b-*','LineWidth',1);
plot(ITER,rate_ergodic(2,:),'k-v','LineWidth',1);
plot(ITER,rate_ergodic(1,:),'m-^','LineWidth',1);
legend('20dB','10dB','0dB','-10dB');

xlabel('iteration');
ylabel('Ergodic sum rate (in bits/s/Hz)');

grid on;