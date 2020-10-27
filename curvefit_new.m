%小车在不同pwm值下的运�?
tp=load('D:\��Ⱥ����\�ź���\����\angular_velocity_10_23_1_short.dat');%maker_location_09_24_3.dat  maker_location_09_25_1_short.dat
scale_x=1420/1920;
scale_y=800/1080;
t=[1:length(tp)]';
y=-tp(:,8);
x=tp(:,9);
phi=unwrap(tp(:,12));

ft = fittype( 'smoothingspline' );
opts = fitoptions( 'Method', 'SmoothingSpline' );
opts.SmoothingParam = 0.9;
fx = fit( t, x, ft, opts );
fy = fit( t, y, ft, opts );
fphi = fit( t, phi, ft, opts );
vx=scale_x*(fx(t+1)-fx(t))/0.1; %0.1：视频帧率为10
vy=scale_y*(fy(t+1)-fy(t))/0.1;
w=(fphi(t+1)-fphi(t))/0.1;
v=sqrt(vx.^2+vy.^2);
v(v>45)=0;



% figure
% plot(fx,t,x)
% title('x轴方向位移与时间t');
% xlabel('t')
% ylabel('位移x')
% figure
% plot(fy,t,y)
% title('y轴方向位移与时间t');
% xlabel('t')
% ylabel('位移y')
% figure
% plot(fphi,t,phi)
% title('小车取向phi与时间t');
% xlabel('t')
% ylabel('取向phi')

figure
plot(t,w) 
title('w');
xlabel('t')
ylabel('角�?�度W')
figure 
plot(t,v)
title('小车速度V与时间t');
xlabel('t')
ylabel('速度V')

% framestart=table2array(framestartend(:,1));
% frameend=table2array(framestartend(:,2));
% pwmset_l=table2array(pwmset1023(:,1));
% pwmset_r=table2array(pwmset1023(:,2));
% figure
% plot(w,'b')
% for jjj=1:length(framestart)
%     W_m(jjj)=mean(w(framestart(jjj):frameend(jjj)));
%     W_m1(framestart(jjj):frameend(jjj))=W_m(jjj);
%     hold on
%     plot(t(framestart(jjj):frameend(jjj)),W_m1(framestart(jjj):frameend(jjj)),'r')
% end
% title('小车角�?�度W与时间t');
% xlabel('t')
% ylabel('角�?�度W')
% 
% figure
% plot(t,v,'b')
% for iii=1:length(framestart)
%   V_m(iii)=mean(v(framestart(iii):frameend(iii)));
%   V_m1(framestart(iii):frameend(iii))=V_m(iii);
%   hold on
%   plot(t(framestart(iii):frameend(iii)),V_m1(framestart(iii):frameend(iii)),'r')
% end
% title('小车速度V与时间t');
% xlabel('t')
% ylabel('速度V')
% 
% % % % % % %验证差分公式
% r=11.46/2;
% L=29.10;
% for kkk=1:length(framestart)
%     if (pwmset_l(kkk)<0)&&(pwmset_r(kkk)<0)
%         V_m(kkk)=-V_m(kkk);
%     end
%     w_r(kkk)=(2*V_m(kkk)+L*W_m(kkk))/2/r;
%     w_l(kkk)=(2*V_m(kkk)-L*W_m(kkk))/2/r;
% %     if rr(kkk)<0
% %         w_r(kkk)=-abs(w_r(kkk));
% %     end
% %     if ll(kkk)<0
% %         w_l(kkk)=-abs(w_l(kkk));
% %     end
% %     if (pwmset_l(kkk)<0)&&(pwmset_r(kkk)<0)
% %         w_r(kkk)=-abs(w_r(kkk));
% %         w_l(kkk)=-abs(w_l(kkk));
% %     end
% end
% % [rr,order_r]=sort(rr);
% % [ll,order_l]=sort(ll);
% % w_r=w_r(order_r);
% % w_l=w_l(order_l);
% 
% [c_r,I_r]=sort(pwmset_r);
% [si_r,ei_r,nn_r,iv_r]=FindStartEndIndex(c_r);
% pwm_omega_r=zeros(length(iv_r),2);
% for i=1:size(pwm_omega_r,1)
%     pwm_omega_r(i,1)=iv_r(i);
%     pwm_omega_r(i,2)=mean(w_r(I_r(si_r(i):ei_r(i))));
% end
% 
% [c_l,I_l]=sort(pwmset_l);
% [si_l,ei_l,nn_l,iv_l]=FindStartEndIndex(c_l);
% 
% pwm_omega_l=zeros(length(iv_l),2);
% for i=1:size(pwm_omega_l,1)
%     pwm_omega_l(i,1)=iv_l(i);
%     pwm_omega_l(i,2)=mean(w_l(I_l(si_l(i):ei_l(i))));
% end
% figure
% plot(pwm_omega_r(:,1),pwm_omega_r(:,2),'r*')
% title('右轮差分w_r')
% xlabel('PWM')
% ylabel('angular velocity')
% 
% figure
% plot(pwm_omega_l(:,1),pwm_omega_l(:,2),'b*')
% title('左轮差分w_l')
% xlabel('PWM')
% ylabel('angular velocity')
% % 
% l_pwm_n=abs(pwm_omega_l(1:40,1));
% l_pwm_p=pwm_omega_l(41:80,1);
% l_omega_n=abs(pwm_omega_l(1:40,2));
% l_omega_p=pwm_omega_l(41:80,2);
% 
% r_pwm_n=abs(pwm_omega_r(1:40,1));
% r_pwm_p=pwm_omega_r(41:80,1);
% r_omega_n=abs(pwm_omega_r(1:40,2));
% r_omega_p=pwm_omega_r(41:80,2);
% 
% % figure
% % plot(pwmset_l,w_l,'r*')
% % hold on
% % plot(pwmset_r,w_r,'b>')
% 
% 
% 
% 
% % figure
% % plot(pwm_omega_r(:,1),pwm_omega_r(:,2),'r*')
% % hold on
% % plot(pwm_omega_l(:,1),pwm_omega_l(:,2),'b*')
% % hold on
% % plot(r_pwm,r_omega,'r>')
% % hold on
% % plot(l_pwm,l_omega,'b>')
% % legend('右轮差分w_r','左轮差分w_l','右轮空转w_r','左轮空转w_l')
% % xlabel('PWM')
% % ylabel('angular velocity')
% % 
% % 
% % figure
% % plot(rr,w_r,'r*')
% % hold on
% % plot(ll,w_l,'b*')
% % legend('差分w_r','差分w_l')
% % 
% % plot(r_p_pwm,r_p_omega,'r>')
% % plot(l_p_pwm,l_p_omega,'b>')
% % plot(l_n_pwm,l_n_omega,'b>')
% % plot(r_n_pwm,r_n_omega,'r>')
% % r_pwm_d=pwm_omega_r(:,1);
% % r_omega_d=pwm_omega_r(:,2);
% % l_pwm_d=pwm_omega_l(:,1);
% l_omega_d=pwm_omega_l(:,2);