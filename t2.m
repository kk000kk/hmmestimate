%%%%×´Ì¬¹À¼Æ%%%%%%%
D=200;
global A B C L tol EVENT;
A=[0.9 0;0.3 0.8];
B=[1 0;0 1];
C=[0.9 0.3];
L=[0 0];
[x_test,y_test,u_test]=Sys3(0,0,D);
x_test_turned=zeros(1,D);
y_test_turned=zeros(1,D);
sign=ones(1,D);
x_test_est=zeros(2,D);
A=[0.9 0;0.3 0.8];
B=[1 0;0 1];
C=[0.9,0.3];
Q=1;
R=0.25;



EVENT=20;
der=x2_value(EVENT+1)-x2_value(1);
for j=2:D           %ÅÅ³ıÊäÈë
        x_test(:,j)=x_test(:,j)-B*u_test(:,j-1);
        y_test(j)=y_test(j)-L*u_test(:,j);

end
      y(1)=y(1)-L*u_test(:,1);


for i=1:D
        [~,k_x1]=min((x1_value-x_test(1,i)).^2);
        [~,k_x2]=min((x2_value-x_test(2,i)).^2);
        x_test_turned(i)=x1_vnum*(k_x2-1)+k_x1;
        [~,y_test_turned(i)]=min((y_value-y_test(i)).^2);
end

for j=2:D
    if abs(y_test_turned(j)-y_test_turned(j-1))<EVENT
        y_test_turned(j)=y_test_turned(j-1);
        sign(j)=0;
    end
end

x_hat=Kalmanf(A,B,C,Q,R,y_test,u_test,sign,der);

q_hat=sparse(M,1);
p_hat=sparse(M,1);
o_hat=sparse(1,M);
q_hat(x_test_turned(1))=1;
x_test_est(1,:)=x_test(1,:);
for i=1:D
    for j=1:M
        y_hat=sparse(1,K);
        y_hat(y_test_turned(i))=1;
        o_hat(j)=(2^tol+1)*sum(E(j,:).*y_hat);
    end
   
      q_hat_n=TR'*diag(o_hat)*q_hat;
if norm(q_hat_n,1)~=0
    q_hat=q_hat_n./norm(q_hat_n,1);
end
    [NUM_q,~]=size(q_hat);
    x_test_num=[];
    x_test_v=[];
    for j=1:NUM_q
        if q_hat(j)~=0
            x_test_num=[x_test_num j];
            x_test_v=[x_test_v q_hat(j)];
        end
    end
    [~,NUM_x_num]=size(x_test_num);
    x1_save=zeros(1,NUM_x_num);
    x2_save=zeros(1,NUM_x_num);
    for j=1:NUM_x_num
    if mod(x_test_num(j),x1_vnum)~=0
    x1=abs(round(mod(x_test_num(j),x1_vnum)));
    x2=abs(round((x_test_num(j)-x1)/x1_vnum)+1);
    else if mod(x_test_num(j),x1_vnum)==0
            x1=x1_vnum;
            x2=x_test_num(j)/x1_vnum;
        end
    end
    x1_save(j)=x1_value(x1);
    x2_save(j)=x2_value(x2);
    end
            
    x_test_est(1,i)=x1_save*x_test_v';
    x_test_est(2,i)=x2_save*x_test_v';
    clc
    fprintf('state estmate %d/%d\n    x1_est_er=%d    x2_est_er=%d',i,D,x_test_est(1,i)-x_test(1,i),x_test_est(2,i)-x_test(2,i));
end




figure(2)
subplot(2,4,1:2);
plot(x_test(1,:),'r','LineWidth',1);
hold on;
plot(x_test_est(1,:),'g','LineWidth',0.5);
hold on;
plot(x_hat(1,:),'b','LineWidth',0.5);
legend('×´Ì¬1','HMMs¹À¼Æ','KalmanÂË²¨')

subplot(2,4,3:4);
plot(x_test(2,:),'r','LineWidth',1);
hold on;
plot(x_test_est(2,:),'g','LineWidth',0.5);
hold on;
plot(x_hat(2,:),'b','LineWidth',0.5);
legend('×´Ì¬2','HMMs¹À¼Æ','KalmanÂË²¨')

subplot(2,4,5)
plot(x_test(1,:)-x_hat(1,:));
title('×´Ì¬1µÄKalmanÂË²¨Îó²î');

subplot(2,4,6)
plot(x_test(1,:)-x_test_est(1,:));
title('×´Ì¬1µÄHMMs¹À¼ÆÎó²î');

subplot(2,4,7)
plot(x_test(2,:)-x_hat(2,:));
title('×´Ì¬2µÄKalmanÂË²¨Îó²î');

subplot(2,4,8)
plot(x_test(2,:)-x_test_est(2,:));
title('×´Ì¬2µÄHMMs¹À¼ÆÎó²î');

figure(3)
plot(sign,'o');



