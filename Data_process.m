clear all
clc
%data input
fid = load('D:\蜂群课题\张何朋\代码\data_process.dat');
l = length(fid); %the length of the matrix
t = fid(:,1); % frames
w = fid(:,2); % angular velocity
v = fid(:,3); % linear velocity

%get the difference of angular velocity and linear velocity
fid1 = fid(2:end,:);% delete the first line
fid2 = fid; fid2(end,:)=[];%delete the last line
diff = fid1 - fid2;%get the difference
%thus the position of a sudden change start from n, and end at n+1


p = 4.5; % parameter of the denoise algorithm, the differ less than p*stand_deviation will be seen as noise;
list_num = 10; %parameter of the number of data in a list to calculate the standard_deviation
diff_w=abs(diff(:,2));
A1 = find_sudden_change_diff(p,diff_w,list_num);
X=[];Y=[];
for i = 1:length(A1)
    X=[X,A1(i)];
    Y=[Y,w(A1(i))];
end

% p_mean = 3;
% A2 = find_sudden_change_diff(p_mean,w,list_num);
% X1=[];Y1=[];
% for i = 1:length(A2)
%     X1=[X1,A2(i)];
%     Y1=[Y1,w(A2(i))];
% end

% %plot
% figure
% t(1,:)=[];
% plot(t,diff_w)
figure
plot(t,w) 
title('w');
xlabel('t')
ylabel('w')
hold on
plot(X,Y,'r*');
hold off

% figure
% plot(t,v) 
% title('v');
% xlabel('t')
% ylabel('v')
% hold on
% plot(X1,Y1,'r*');
% hold off


% figure 
% plot(t,v)
% title('v');
% xlabel('t')
% ylabel('v')