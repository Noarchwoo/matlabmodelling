function I = mesh_new(dump,zlo,zhi,lattice)%mesh box
xhi = max(dump(:,2));
xlo = min(dump(:,2));
yhi = max(dump(:,3));
ylo = min(dump(:,3));
zhm = max(dump(:,4));
i0 = fix((xhi-xlo)/lattice);
j0 = fix((yhi-ylo)/lattice);
k0 = fix((zhi-zlo)/lattice);
k1 = fix((zhi-zlo-zhm)/lattice);
% 光滑平板部分
count = 1;
for j = 1 :j0+1
    for k = 1:k0+1
        I_1(count,1) = -i0*lattice/2;
        I_1(count,2) = -j0*lattice/2 + (j-1)*lattice;
        I_1(count,3) = zlo + (k+0.5)*lattice;
        count = count + 1;
    end
end 
% % 有纳米凸起部分
% count2 = 1;
% for j = 1 :j0+1
%     for k = 1:k1+3
%         I_1_2(count2,1) = -i0*lattice/2;
%         I_1_2(count2,2) = -j0*lattice/2 + (j-1)*lattice;
%         I_1_2(count2,3) = zhm + (k+0.5)*lattice;
%         count2 = count2 + 1;
%     end
% end

size_I_1 = size(I_1);
v1 = [lattice 0 0];

varible_x = dump(:,2);

for i = 0 : i0
    t = intersect(find(varible_x>(i-0.6)*lattice-i0*lattice/2),find(varible_x<(i+0.6)*lattice-i0*lattice/2));
    d = dump(t,:);
    varible_I_z = I_1(:,3);
    temp2 = find(varible_I_z>max(d(:,4))+lattice);
    size_temp2 = size(temp2);
        I_2(1:size_temp2(1),1:3) = I_1(temp2,1:3)+i*meshgrid(v1,1:size_temp2(1));
        if i == 0
            I = I_2;
        else
            I = union(I,I_2,'rows');
        end
        clear I2;
end