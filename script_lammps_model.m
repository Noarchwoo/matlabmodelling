% tic
B_Cu = creat_spring_bond(dumpcu,2.56,1);%�������Ҫ�����ļ������ã�2.56�ǳɼ��Ľضϰ뾶
I_O = mesh_new(dumpcu,7.3,903,3.203); %����ˮ���ӵ����꣬ͬʱ����Cuԭ�������ˮ����ȥ��������7.3,900��ˮ���ӵ������ޣ�3.203��sc�ṹˮ�����ܶȼ��������
I_water = creat_water(I_O);%����ˮ����
writelammpsdata('water_rect_1r.4.25',dumpcu,I_water,B_Cu);%������
% toc