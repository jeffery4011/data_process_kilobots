function A = find_sudden_change_diff(p,diff,list_num)
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明
A=[];
l = length(diff);
number_list=[]; %save the diff for caculating the standard deviation value
i = 1;
    while(i<l)
        number_list=[number_list,diff(i)];
        
        if diff(i)>p*std(number_list) && length(number_list)>list_num 
            A=[A;i];
            number_list=[];
        end
    
        i=i+1;
    end
    l_A=length(A);
    disp(l_A);
%     for t=1:1:l_A
%        if A(t+1)-A(t)<70
%            A(t+1)=[];
%        end
%     end

end

