function [M,S] = Movement_detection(x,y,ang,position_standard,angular_standard,step)
%M includes moving points and S includes stop points
%x,y is the postion, ang is the direction
%position_standard is the standard for position movement judgement
%angular_standard is the standard for angular movement judgement
M = [];
S = [];
    for i=1+step:1:length(x)-step
        test_list_x=x(i-step:1:i+step);
        test_list_y=y(i-step:1:i+step);
        test_list_ang=ang(i-step:1:i+step);
        if (range(test_list_x)>position_standard) || (range(test_list_y)>position_standard) ||(range(test_list_ang)>angular_standard)
            M = [M;i]; %if meet the standard this point is a moving point
        else
            S = [S;i]; % if not, it's a stopping point
        
    end
end


