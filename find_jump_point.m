function [A] = find_jump_point(B,prem)
%UNTITLED12 此处显示有关此函数的摘要
%   此处显示详细说明
Begin=[B(1)+prem];
Stop=[];
for i=1:1:length(B)-1
    if B(i+1)>B(i)+1
        Stop=[Stop;B(i)-prem];
        Begin = [Begin;B(i+1)+prem];
    end
    

end
Stop=[Stop;B(end)-5*prem];
A=[Begin,Stop];
end

