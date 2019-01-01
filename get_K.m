function [ output ] = get_K( i,u,Lambda)     % sum H*Lambda*H
%% �õ������� K ��   iΪС����� uΪ�û���� ���û��յ�������վ���ź�,NbΪС��������Ҫ����
% Lambda Nt * Nu
global h_freq;
global Omega;
global Nu;
global Nb;
[Nr,~,~]=size(h_freq);

K_noise = zeros(Nr,Nr);
K_noise_sum = zeros(Nr,Nr);
for k=1:Nb
    if(k~=i)
         for n = 1:Nr
                   K_noise(n,n) = Omega(n,:,Nb*Nu*(k-1)+Nu*(i-1)+u)*Lambda(:,k);                  
         end
    end
    
    K_noise_sum = K_noise_sum + K_noise;
end

output = eye(Nr) + K_noise_sum;

