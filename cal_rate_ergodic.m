function [ rate_sum ] = cal_rate_ergodic(Lambda)
% ����������
% Lambda Nt*Nb

global h_freq;
global Nu;
global Nb;

[Nr,~,NF,NoSamples,~]=size(h_freq);

rate_sum = 0;
K = zeros(Nr,Nr);

for i = 1:Nb               %��i��С��
    rate_i = zeros(1,Nu);  %��i��С���ĸ����û������� 1*Nu
    for u = 1:Nu           %��i��С����u���û�
        rate_i(1,u) = 0;
        K = get_K(i,u,Lambda);                    %��i��С����u���û��յ��ĸ���
        for freq_i = 1:NF
            for n_sample = 1:NoSamples
                A = h_freq(:,:,freq_i,n_sample,Nb*Nu*(i-1)+Nu*(i-1)+u);                
                rate_i(1,u) = rate_i(1,u) + log(abs(det(K+A*diag(Lambda(:,i))*A')));
            end
        end
        
        rate_i(1,u) = rate_i(1,u)/NoSamples/NF;                 %��һ�������
        
        
        
        rate_i(1,u) = rate_i(1,u) - log(abs(det(K)));           %��ʽ��8��
        rate_i(1,u) = max(rate_i(1,u),0);
       
    end
    rate = min(rate_i);
    rate_sum = rate_sum + rate;
end
    rate_sum = rate_sum/log(2);



end

