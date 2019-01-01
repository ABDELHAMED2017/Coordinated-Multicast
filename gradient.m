function [ Gra ] = gradient( i,u,k,Lambda )
%Lambda Nt * Nb     ���� Lambda_k ��ƫ��
% iС����� u�û����
% k!=u 
global Omega;
global Nb;
global Nu;
[Nr,Nt,~] = size(Omega);

Gra = zeros(Nt,Nt);

for t = 1:Nt   % t�Խ���Ԫ��
%     b = 0;
%     for n = 1:Nr
%         a = 0;
%         for j = 1:Nb
%             if j ~=i
%                 for m = 1:Nt
%                     a = a + Omega(n,m,Nb*Nu*(j-1)+Nu*(i-1)+u)*Lambda(m,j);
%                 end
%             end
%         end
%         b = b + Omega(n,t,Nb*Nu*(k-1)+Nu*(i-1)+u)/(1 + a);
%     end
%     Gra(t,t) = b;
    b = 0;
    for n = 1:Nr
        up = Omega(n,t,Nb*Nu*(k-1)+Nu*(i-1)+u);
        down = 0;
        for j =1:Nb
            if j ~= i
                for m = 1:Nt
                    down = down + Omega(n,m,Nb*Nu*(j-1)+Nu*(i-1)+u) *Lambda(m,j);
                end
            end
        end
        a = up/(1+down);
        b = b +a;
    end
    Gra(t,t) = b;
end

end

