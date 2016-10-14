function writelammpsdata(filename,I_Cu_fcc,I_water,bond_Cu)
q_H = 0.417;
q_O = -0.834;
q_Cu = 0;
mass  =  [63.5;63.5;1.008;15.9994];
mass(5:30) = 63.5;
size_Cu = size(I_Cu_fcc);
size_water = size(I_water);
size_Cu_bond = size(bond_Cu);
atom_types_num = max(max(I_Cu_fcc(:,1)),4);
bond_types_num = 2;
angle_types_num = 1;
num_water = size_water(1)/3;
atoms_num = size_Cu(1)+size_water(1);
bonds_num = size_Cu_bond(1) + num_water*2;
angles_num = num_water;
I = [I_Cu_fcc;I_water];
xlo = min(I(:,2));
ylo = min(I(:,3));
zlo = min(I(:,4));
xhi = max(I(:,2))+3.615/2;
yhi = max(I(:,3))+3.615/2;
zhi = max(I(:,4))+3.615/2;

outfilename  = strcat(filename,'.data');
fidout = fopen(outfilename,'w');
new_comment  = ['Nanofluid model build with Matlab ',datestr(now)];
fprintf(fidout,'%s\n\n',new_comment);
fprintf(fidout,'%d \t %s\n',atoms_num,'atoms');
fprintf(fidout,'%d \t %s\n',bonds_num,'bonds');
fprintf(fidout,'%d \t %s\n',angles_num,'angles');
fprintf(fidout,'%d \t %s\n',atom_types_num,'atom types');
fprintf(fidout,'%d \t %s\n',bond_types_num,'bond types');
fprintf(fidout,'%d \t %s\n',angle_types_num,'angle types');
fprintf(fidout,'%f  %f \t%s\n',xlo,xhi,'xlo xhi');
fprintf(fidout,'%f  %f \t%s\n',ylo,yhi,'ylo yhi');
fprintf(fidout,'%f  %f \t%s\n\n',zlo,zhi,'zlo zhi');
fprintf(fidout,'%s\n\n','Masses');
for i = 1 : max(I(:,1))
    fprintf(fidout,'%d  %f \t\n',i,mass(i));
end
fprintf(fidout,'\n%s\n\n','Atoms');

for i = 1 : size_Cu(1)
    fprintf(fidout,'%d \t %d \t %d \t %f \t %f \t %f \t %f \n',...
    i,i,I_Cu_fcc(i,1),q_Cu,I_Cu_fcc(i,2),I_Cu_fcc(i,3),I_Cu_fcc(i,4));
end

for i = 1 : size_water(1)
    if I_water(i,1) <= 3
        fprintf(fidout,'%d \t %d \t %d \t %f \t %f \t %f \t %f \n',...
        size_Cu(1)+i,size_Cu(1)+ceil(i/3),I_water(i,1),q_H,I_water(i,2),I_water(i,3),I_water(i,4));
    else
        fprintf(fidout,'%d \t %d \t %d \t %f \t %f \t %f \t %f \n',...
        size_Cu(1)+i,size_Cu(1)+ceil(i/3),I_water(i,1),q_O,I_water(i,2),I_water(i,3),I_water(i,4));
    end
end


fprintf(fidout,'\n%s\n\n','Bonds');
for i = 1 : size_Cu_bond(1)
    fprintf(fidout,'%d \t %d \t %d \t %d \n',...
    i,bond_Cu(i,3),bond_Cu(i,1),bond_Cu(i,2));
end
for i = 1 : size_water(1)
    if I_water(i,1) >= 4
        fprintf(fidout,'%d \t %d \t %d \t %d \n',...
        size_Cu_bond(1)+ceil(i/3)*2-1,2,size_Cu(1)+i,size_Cu(1)+i+1);
        fprintf(fidout,'%d \t %d \t %d \t %d \n',...
        size_Cu_bond(1)+ceil(i/3)*2,2,size_Cu(1)+i,size_Cu(1)+i+2);
    end
end

fprintf(fidout,'\n%s\n\n','Angles');
for i = 1 : size_water(1)
    if I_water(i,1)>=4
        fprintf(fidout,'%d \t %d \t %d \t %d \t %d \n',ceil(i/3),1,size_Cu(1)+i+1,size_Cu(1)+i,size_Cu(1)+i+2);
    end
end
fclose(fidout);
