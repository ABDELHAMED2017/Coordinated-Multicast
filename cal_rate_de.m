function [ rate_sum ] = cal_rate_de( Lambda )   
%%%%%%%%%%%%%%%ȷ���Ե�ͬ
% Lambda Nt*Nb     

global Nu;
global Nb;

rate_sum = 0;

for i = 1:Nb               %��i��С��
    rate_i = zeros(1,Nu);  %��i��С���ĸ����û������� 1*Nu
    for u = 1:Nu           %��i��С����u���û�
        rate_i(1,u) = 0;
        K = get_K(i,u,Lambda);   % Nr * Nr ��i��С����u���û��յ�����
        [rate_i(1,u),~,~,~] = cal_rate_de_par(i,u,Lambda(:,i),K);       %��ʽ(13)(14)
        rate_i(1,u)= rate_i(1,u) - log(abs(det(K)));
        rate_i(1,u) = max(0,rate_i(1,u));       
    end
    rate = min(rate_i);
    rate_sum = rate_sum + rate;
end
 rate_sum = rate_sum/log(2);


end

