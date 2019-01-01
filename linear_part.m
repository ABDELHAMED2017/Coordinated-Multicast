function [ R_2_i_u ] = linear_part( Lambda_i , Lambda_new ,i,u)
%% �������Ի��� ��i��С�� ��u���û�
% Lambda_i Lambda_new  Nt*Nb ����Lambda_new ��cvx�Ż�      
global Nb;
global Omega
[~,Nt,~]= size(Omega);

a = 0;
for k = 1:Nb
    if k ~= i
          a = a  + trace( gradient(i,u,k,Lambda_i) * diag(Lambda_new(:,k)) - gradient(i,u,k,Lambda_i) * diag(Lambda_i(:,k))) ;         %��ʽ(19)���Բ���
    end
end

R_2_i_u = a + log_det(get_K(i,u,Lambda_i));



