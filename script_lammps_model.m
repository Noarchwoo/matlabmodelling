% tic
B_Cu = creat_spring_bond(dumpcu,2.56,1);%因加热需要创建的键的作用，2.56是成键的截断半径
I_O = mesh_new(dumpcu,7.3,903,3.203); %建立水分子的坐标，同时将和Cu原子相近的水分子去掉。其中7.3,900是水分子的上下限，3.203是sc结构水分子密度计算出来的
I_water = creat_water(I_O);%创建水分子
writelammpsdata('water_rect_1r.4.25',dumpcu,I_water,B_Cu);%输出结果
% toc