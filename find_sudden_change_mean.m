function A = find_sudden_change_mean(p,data,list_num)
%UNTITLED6 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
A=[];
l = length(data);
number_list=[]; %save the diff for caculating the standard deviation value
i = 1;
    while(i<l)
        number_list=[number_list,data(i)];
        
        if abs(data(i)-mean(number_list))>p*std(number_list) && length(number_list)>list_num 
            A=[A;i];
            number_list=[];
        end
    
        i=i+1;
    end
end

