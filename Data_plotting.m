clear all
clc
tp=load('D:\蜂群课题\张何朋\代码\data_process_kilobots\data_process_kilobots\angular_velocity_10_23_1_short.dat');
phi1=unwrap(tp(:,12));
phi2 = phi1(2:end);
phi2 = [phi2;phi1(end)];
phi = (phi1+phi2)./2;
fid = load('D:\蜂群课题\张何朋\代码\data_process_kilobots\data_process_kilobots\data_process.dat');
l = length(fid); %the length of the matrix
t = fid(:,1); % frames
w = fid(:,2); % angular velocity
v = fid(:,3); % linear velocity
vid = load('D:\蜂群课题\张何朋\代码\data_process_kilobots\data_process_kilobots\velocity.dat');
vx = vid(:,1);
vy = vid(:,2);
vx(abs(cos(phi))<1e-2)=0;
vx(abs(vx)>45)=0;
% the parameter of the robot
r=11.46/2;
L=29.10;
vx_phi = vx./cos(phi);
Trans_Matrix = inv([r/2,r/2;r/L,-r/L]);



figure
plot(t,w) 
title('w');
xlabel('t')
ylabel('W')
figure 
plot(t,v)
title('v');
xlabel('t')
ylabel('V')

framestartend = load('D:\蜂群课题\张何朋\代码\data_process_kilobots\data_process_kilobots\frame_start_end.txt');

framestart=framestartend(:,1);
frameend=framestartend(:,2);

pwmset1023 = load('D:\蜂群课题\张何朋\代码\data_process_kilobots\data_process_kilobots\pwmset1023.txt');
pwmset_l=pwmset1023(:,1);
pwmset_r=pwmset1023(:,2);
figure
plot(w,'b')
for jjj=1:length(framestart)
    W_m(jjj)=mean(w(framestart(jjj):frameend(jjj)));
    W_m1(framestart(jjj):frameend(jjj))=W_m(jjj);
    hold on
    plot(t(framestart(jjj):frameend(jjj)),W_m1(framestart(jjj):frameend(jjj)),'r')
end
title('');
xlabel('t')
ylabel('W')

figure
plot(t,v,'b')
for iii=1:length(framestart)%start_point
  V_m(iii)=mean(v(framestart(iii):frameend(iii)));
  V_m1(framestart(iii):frameend(iii))=V_m(iii);
  hold on
  plot(t(framestart(iii):frameend(iii)),V_m1(framestart(iii):frameend(iii)),'r')
end
title('');
xlabel('t')
ylabel('V')

for iii=1:length(framestart)%start_point
  V_mx_phi(iii)=mean(vx_phi(framestart(iii):frameend(iii)));
  V_mx_phi1(framestart(iii):frameend(iii))=V_m(iii);
  hold on
  plot(t(framestart(iii):frameend(iii)),V_mx_phi1(framestart(iii):frameend(iii)),'r')
end
title('');
xlabel('t')
ylabel('V_phi')

% % % % % %楠岃瘉宸垎鍏紡

 Phi_Matrix = [r/2,r/2;r/L,-r/L]\ [V_mx_phi;W_m];
 w_rphi = Phi_Matrix(1,:); w_lphi = Phi_Matrix(2,:);

for kkk=1:length(framestart)
    if (pwmset_l(kkk)<0)&&(pwmset_r(kkk)<0)
        V_m(kkk)=-V_m(kkk);
    end
    w_r(kkk)=(2*V_m(kkk)+L*W_m(kkk))/2/r;
    w_l(kkk)=(2*V_m(kkk)-L*W_m(kkk))/2/r;
%     if rr(kkk)<0
%         w_r(kkk)=-abs(w_r(kkk));
%     end
%     if ll(kkk)<0
%         w_l(kkk)=-abs(w_l(kkk));
%     end
%     if (pwmset_l(kkk)<0)&&(pwmset_r(kkk)<0)
%         w_r(kkk)=-abs(w_r(kkk));
%         w_l(kkk)=-abs(w_l(kkk));
%     end
end
% [rr,order_r]=sort(rr);
% [ll,order_l]=sort(ll);
% w_r=w_r(order_r);
% w_l=w_l(order_l);

[c_r,I_r]=sort(pwmset_r);
[si_r,ei_r,nn_r,iv_r]=FindStartEndIndex(c_r);
pwm_omega_r=zeros(length(iv_r),2);
pwm_omega_rphi=zeros(length(iv_r),2);
for i=1:size(pwm_omega_r,1)
    pwm_omega_r(i,1)=iv_r(i);
    pwm_omega_r(i,2)=mean(w_r(I_r(si_r(i):ei_r(i))));
    pwm_omega_rphi(i,1)=iv_r(i);
    pwm_omega_rphi(i,2)=mean(w_rphi(I_r(si_r(i):ei_r(i))));
end

[c_l,I_l]=sort(pwmset_l);
[si_l,ei_l,nn_l,iv_l]=FindStartEndIndex(c_l);

pwm_omega_l=zeros(length(iv_l),2);
pwm_omega_lphi=zeros(length(iv_r),2);
for i=1:size(pwm_omega_l,1)
    pwm_omega_l(i,1)=iv_l(i);
    pwm_omega_l(i,2)=mean(w_l(I_l(si_l(i):ei_l(i))));
    pwm_omega_lphi(i,1)=iv_l(i);
    pwm_omega_lphi(i,2)=mean(w_lphi(I_l(si_l(i):ei_l(i))));
end
figure
plot(pwm_omega_r(:,1),pwm_omega_r(:,2),'r*',pwm_omega_rphi(:,1),pwm_omega_rphi(:,2),'gx')
title('w_r')
xlabel('PWM')
ylabel('angular velocity')

figure
plot(pwm_omega_l(:,1),pwm_omega_l(:,2),'b*',pwm_omega_lphi(:,1),pwm_omega_lphi(:,2),'yx')
title('w_l')
xlabel('PWM')
ylabel('angular velocity')