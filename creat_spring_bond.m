function B_Cu = creat_spring_bond(I_Cu_fcc,l_bond,bond_type)

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
num = 0;
a = size(I_Cu_fcc);
for k = 1 : a(1);
    if I_Cu_fcc(k,1)<3
        num = num + 1;
    end
end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
length_x = 8;
max_x = max(I_Cu_fcc(:,2));
min_x = min(I_Cu_fcc(:,2));
n_part = ceil((max_x-min_x)/length_x);
varible_x = I_Cu_fcc(:,2);
varible_z = I_Cu_fcc(:,4);
for j = 1:n_part
    count = 1;
    p_max_x = min_x+j*length_x+l_bond;
    p_min_x = min_x+(j-1)*length_x-l_bond;
    t = intersect(find(varible_x>p_min_x),find(varible_x<p_max_x));
    t = intersect(find(varible_z<=0),t);
    d = I_Cu_fcc(t,:);
    d(:,5) = t;
    size_d = size(d);
    for k = 1:size_d(1)-1
        for n = k+1:size_d(1)
            b = sqrt(dot((d(k,2:4)-d(n,2:4)),(d(k,2:4)-d(n,2:4))));
            if b<l_bond
                B_Cu_j(count,1) = d(k,5);
                B_Cu_j(count,2) = d(n,5);
                B_Cu_j(count,3) = bond_type;
                count = count + 1;
            end
        end
    end
    if (j ==1)
        B_Cu = B_Cu_j;
    else
        B_Cu = union(B_Cu_j,B_Cu,'rows');
    end
end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

% count = 1;
% for i = 1 : 
%     for j = i+1 : num
%         b = sqrt(dot((I_Cu_fcc(i,2:4)-I_Cu_fcc(j,2:4)),(I_Cu_fcc(i,2:4)-I_Cu_fcc(j,2:4))));
%         if b<l_bond %& I_Cu_fcc(i,1)< 5 & I_Cu_fcc(j,1) <5
%             B_Cu(count,1) = i;
%             B_Cu(count,2) = j;
%             B_Cu(count,3) = bond_type;
%             count = count + 1;
%         end
%     end
% end