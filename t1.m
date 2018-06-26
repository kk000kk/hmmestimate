clear all;
N=100;                  %%N������
D=1000;                  %%ÿ�����ݳ���
global tol;
tol=8;                  %%���ݾ���
y=zeros(N,D);
x=zeros(2*N,D);
u=zeros(N,D);
x_turned=zeros(N,D);
y_turned=zeros(N,D);
global EVENT;
EVENT=20;
k=1;
LOOP=10;
TR=sparse((2^tol)^2+2^(1+tol)+1,(2^tol)^2+2^(1+tol)+1);
E=sparse((2^tol)^2+2^(1+tol)+1,(2^tol)+1);
global A B C L;
A=[0.9 0;0.3 0.8];
B=[1 0;0 1];
C=[0.9 0.3];
L=[0 0];

for loop=1:LOOP
for i=1:N
    [x(2*i-1:1:2*i,:),y(i,:),u(2*i-1:2*i,:)]=Sys3(rand(1,1)*10-5,rand(1,1)*10-5,D);
    clc
   fprintf('��������   %d/%d     loop %d/%d\n',i,N,loop,LOOP);
end          %%%��������


for j=2:D           %�ų�����
    for i=1:N
        x(2*i-1:2*i,j)=x(2*i-1:2*i,j)-B*u(2*i-1:2*i,j-1);
        y(i,j)=y(i,j)-L*u(2*i-1:2*i,j);
    end
    for i=1:N
        y(i,1)=y(i,1)-L*u(2*i-1:2*i,1);
    end
    clc
    fprintf('�ų����� �� %d/%d   LOOP %d/%d\n',j,D,loop,LOOP);
end


[x1_min,~]=min(x(1,:));
[x2_min,~]=min(x(2,:));
[x1_max,~]=max(x(1,:));
[x2_max,~]=max(x(2,:));
x1_value=x1_min:(x1_max-x1_min)/2^tol:x1_max;
x2_value=x2_min:(x2_max-x2_min)/2^tol:x2_max;
x1_vnum=size(x1_value);
x1_vnum=x1_vnum(2);
x2_vnum=size(x2_value);
x2_vnum=x2_vnum(2);
y_min=min(y);
y_max=max(y);
y_value=y_min:(y_max-y_min)/2^tol:y_max;

for i=1:N
    for j=1:D
        [~,k_x1]=min((x1_value-x(2*i-1,j)).^2);
        [~,k_x2]=min((x2_value-x(2*i,j)).^2);
        x_turned(i,j)=x1_vnum*(k_x2-1)+k_x1;

        [~,y_turned(i,j)]=min((y_value-y(i,j)).^2);
           
    end
    clc
     fprintf('������ɢ��    %d/%d      loop %d/%d\n',i,N,loop,LOOP);
end        %ADC



for c=1:N
        
maxx=max(x_turned(c,:));
maxy=max(y_turned(c,:));
[tr(1:maxx,1:maxx),e(1:maxx,1:maxy)] = hmmestimate_k(y_turned(c,:),x_turned(c,:));

[M,K,~]=size(e);


TR_1=TR;
E_1=E;

TR(1:M,1:M)=TR(1:M,1:M)*((loop-1)*N+c-1)/((loop-1)*N+c)+tr*1/((loop-1)*N+c);
E(1:M,1:K)=E(1:M,1:K)*((loop-1)*N+c-1)/((loop-1)*N+c)+e*1/((loop-1)*N+c);

for row=1:(2^tol)^2+2^(1+tol)+1      %��һ��
    s1=sum(TR(row,:));
    s2=sum(E(row,:));
    
    if s1~=0
        TR(row,:)=TR(row,:)/s1;
    end
    if s2~=0
        E(row,:)=E(row,:)/s2;
    end
end

  nor(1,(loop-1)*N+c)=norm(TR-TR_1,1);
  nor(2,(loop-1)*N+c)=norm(E-E_1,1);
  clc
  fprintf('ת�ƾ���ѵ��   %d/%d   loop %d/%d,    datacount:%d\n',c,N,loop,LOOP,(loop-1)*N+c);
end         %%����ѵ��

end


% figure(1);
% subplot(2,1,1);
% mesh(TR);
% subplot(2,1,2);
% mesh(E);


% TR=TR+1e-6;
% E=E+1e-6;
% [x_test,y_test]=Sys3(5,-5,1000);
% for i=1:1000
% y_test_turned(i)=turny(y_test,y_test(i),tol);
% end
% eststates = hmmviterbi(y_test_turned(1,:),TR,E); 
% 
% er=zeros(1,1000);
% for i=1:1000
%     eststates(i)=deturnx(x_test,abs(round(eststates(i))),tol);
%     state(i)=x_test(1,i);
%     er(i)=(eststates(i)-state(i));
% end
% 
% 
% figure(2)
% subplot(3,1,1)
% plot(state);
% subplot(3,1,2)
% plot(eststates);
% subplot(3,1,3)
% plot(er)

figure(1)
subplot(2,1,1)
plot(nor(1,:))
subplot(2,1,2)
plot(nor(2,:))

% save('data5.24.19.10,plan datacountLOOP10')


