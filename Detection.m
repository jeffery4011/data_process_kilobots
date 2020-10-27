clear all
clc
fp=load('D:\蜂群课题\张何朋\代码\angular_velocity_10_23_1_short.dat');
y = fp(:,8);
x = fp(:,9);
phi = fp(:,12);
position_standard = 1.7;
angular_standard = 0.1;
step = 5;
[M,S]= Movement_detection(x,y,phi,position_standard,angular_standard,step);
J = find_jump_point(M,25);
A = J(:,2)>J(:,1);
J(J(:,2)<=J(:,1),:)=[];
save start_end.dat J -ascii

% fid = load('D:\蜂群课题\张何朋\代码\data_process.dat');
% l = length(fid); %the length of the matrix
% t = fid(:,1); % frames
% w = fid(:,2); % angular velocity
% v = fid(:,3); % linear velocity
% 
% figure
% plot(t,w) 
% title('w');
% xlabel('t')
% ylabel('w')
% hold on
% plot(t(J),w(J),'r*')
% 
% hold off